"""Implements management of PULFA Collection records.
These are implemented as EAD documents.
"""
from record import Record
from subprocess import Popen, PIPE
import logging
import re


class Collection(Record):
    def __init__(self, pathtorecord):
        Record.__init__(self, pathtorecord)
        self.service = "collections"
        self.solrizer = self.collectionXSLT
        self._canonicalURI = None
        # generate the solrDoc
        p1 = Popen(["java", "-Xmx16G", "-jar",
                    self.saxon,
                    "-s:" + self.recordPath,
                    "-xsl:" + self.enhancer,
                    "scope=set",
                    "base-uri=" + self.baseURI],
                   stdout=PIPE)
        p2 = Popen(["java", "-Xmx60G", "-jar",
                    self.saxon,
                    "-xsl:" + self.solrizer,
                    "-"],
                   stdin=p1.stdout, stdout=PIPE, stderr=PIPE)
        p1.stdout.close()
        p2out, p2err = p2.communicate()
        if p2.returncode == 0:
            self._solrDoc = p2out.decode("utf-8")
        else:
            logging.error("XSLT failed: {}".format(p2err))
            self._solrDoc = None

    def update(self):
        try:
            super().update()
        except RuntimeError:
            logging.error("update failed with a runtime error")

        if self.solrDoc():
            self.reindex()
        else:
            logging.warning("{} not reindexed".format(self.recordPath))

    def solr_delete_query(self):
        """Compile the query string to pass to pysolr.delete.  Pysolr
        complains about the colon (:) in http://, so we have to escape
        it.
        """
        field = self.canonical_field
        v = re.sub(r'://', r'\://', self.canonicalURI())
        return '{0}:{1}'.format(field, v)

    def solrDoc(self):
        return self._solrDoc
