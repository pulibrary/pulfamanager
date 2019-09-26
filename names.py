"""Implements management of PULFA Name records.
These are implemented as EAC documents.
"""
from record import Record
from subprocess import run, PIPE
import logging
import re


class Name(Record):
    def __init__(self, pathtorecord):
        Record.__init__(self, pathtorecord)
        self.service = "names"
        self.solrizer = self.nameXSLT
        self._solrDoc = None
        self.canonical_field = 'id'
        self._canonicalURI = None

    def update(self):
        super().update()
        self.reindex()

    def solrDoc(self):
        """Returns an XML string representing the solr doc
        for the EAC.

        This method is a wrapper around the self._solrDoc instance
        variable, which is used to cache the results of running two
        XSLT scripts against the EAD document (very expensive).
        """
        if self._solrDoc is None:
            p = run(
                ["java", "-jar", self.saxon,
                 "-s:" + self.recordPath,
                 "base-uri=" + self.baseURI,
                 "-xsl:" + self.solrizer],
                stdout=PIPE
                )
            self._solrDoc = p.stdout.decode("utf-8")
        return self._solrDoc

    def solr_delete_query(self):
        """Compile the query string to pass to pysolr.delete.  Pysolr
        complains about the colon (:) in http://, so we have to escape
        it.

        """
        field = self.canonical_field
        v = re.sub(r'://', r'\://', self.canonicalURI())
        return '{0}:{1}'.format(field, v)
