"""PULFA draws on three kinds of records: Collections (implemented as
EAD XML documents); Names (EAC documents), and Folders (METS
documents). Managing these records for the application entails loading
them into an eXist database and putting them in a Solr index. The full
record sets must be loaded when the application is first installed;
thereafter the database and index need to be updated incrementally
whenever a record is changed. (The records are created, edited, and
maintained externally in a subversion repository; management of that
repository is out of scope for this module.)
"""
import os
import subprocess
import re
from pysolr import Solr, SolrError
import xml.etree.cElementTree as etree
import yaml
import requests
import io
import logging
import random


class Record:
    package_path = os.path.dirname(__file__)
    conf_file = os.path.join(package_path, 'conf.yaml')

    def __init__(self, pathtorecord):
        """Store configuration data in class variables;
        other initialization done by subclasses.
        """
        with io.open(self.conf_file, 'r') as fh:
            conf = yaml.load(fh, Loader=yaml.FullLoader)
            self.baseURI = conf['pulfa']['host']
            self.solrBase = conf['solr']['base_uri']
            self.solr_cores = conf['solr']['cores']
            self.canonical_field = conf['solr']['canonical_field']
            self.existBase = conf['existdb']['base_uri']
            self.pulfa_user = conf['existdb']['pulfa_db_user']
            self.pulfa_pwd = conf['existdb']['pulfa_db_passwd']
            self.enhancer = os.path.join(self.package_path,
                                         conf['xslt']['enhancer'])
            self.collectionXSLT = os.path.join(self.package_path,
                                               conf['xslt']['collection'])
            self.nameXSLT = os.path.join(self.package_path,
                                         conf['xslt']['name'])
            self.saxon = conf['dependencies']['saxon']
        self.recordPath = pathtorecord
        self.service = None

    def isvalid(self):
        code = subprocess.call(["xmllint", "--noout", self.recordPath])
        if code == 0:
            return True
        else:
            return False

    def update(self):
        """All records get stored in the eXistdb. eXist
        overwrites, so records do not need to be deleted first.
        """

        if self.isvalid():
            self.post_to_exist()
        else:
            raise RuntimeError("Record is not valid XML.")

    def db_subpath(self):
        return self.recordPath.split('/')[-1]

    def put_to_exist(self):
        """ Note that the content-type must be
        application/octet-stream, rather than XML; otherwise
        we get a parsing error.
        """
        if self.isvalid():
            url = '/'.join([self.existBase,
                            self.service,
                            self.db_subpath()])
            try:
                with io.open(self.recordPath, 'r', encoding='utf-8') as fh:
                    data = fh.read()
                    response = requests.put(
                        url,
                        data=data.encode('utf-8'),
                        auth=(self.pulfa_user, self.pulfa_pwd),
                        headers={'content-type': 'application/octet-stream'},
                        params={'file': self.recordPath}
                    )
                    logging.info("put " + self.recordPath + " to eXist")
                    return response.status_code, response.reason
            except:
                raise RuntimeError("couldn't write to eXist")
        else:
            raise RuntimeError("Record is not valid XML.")

    def post_to_exist(self):
        if self.isvalid():
            url = '/'.join([self.baseURI,
                            self.service])
            with io.open(self.recordPath, 'r', encoding='utf-8') as fh:
                data = fh.read()
            try:
                response = requests.post(
                    url,
                    auth=(self.pulfa_user, self.pulfa_pwd),
                    headers={'content-type': 'application/xml'},
                    data=data.encode('utf-8'),
                    verify=False
                )
                if response.status_code in [200, 201]:
                    logging.info("posted {0} to eXist: {1}".format(
                        self.recordPath, response.status_code))
                else:
                    logging.error("problem posting {0} to eXist: {1}".format(
                        self.recordPath, response.status_code))
                return response.status_code, response.reason
            except:
                logging.error("couldn't write to exist")
                raise RuntimeError("couldn't write to exist")

    def reindex(self):
        self.delete_from_solr()
        self.add_to_solr()

    def solr_delete_query():
        pass

    def delete_from_solr(self):
        for core in self.solr_cores:
            self.delete_from_solr_core(core)
        logging.info("deleted from solr")

    def add_to_solr(self):
        self.add_to_solr_core(random.choice(self.solr_cores))
        logging.info("added to solr cores")

    def delete_from_solr_core(self, core):
        """ Create a pysolr connection to the core
        and submit the generated delete query.
        """
        solr = self.solr_core_connection(core)
        query = self.solr_delete_query()
        if query:
            try:
                solr.delete(q=query, commit=True)
            except Exception:
                logging.error("couldn't perform solr delete")

    def add_to_solr_core(self, core):
        """ Add the solr doc to the core.
        Pysolr needs that doc to be represented as a dictionary.
        """
        solr = self.solr_core_connection(core)
        try:
            solr.add(self.doc_to_dict())
        except SolrError:
            logging.error("couldn't add to solr core")

    def solr_core_connection(self, core):
        """Returns a pysolr connection to the specified core at solrBase.
        """
        conn = Solr('/'.join([self.solrBase, core]))
        return conn

    def canonicalURI(self):
        """Method wrapper around the instance variable self_canonicalURI. The
        regex search could be expensive, so the value should be
        cached.

        """
        if self._canonicalURI is None:
            pattern = re.compile("<field name=\"%s\">(.*?)<\/field>"
                                 % (self.canonical_field))
            m = pattern.search(self.solrDoc())
            if m:
                self._canonicalURI = m.group(1)
        return self._canonicalURI

    def doc_to_dict(self):
        """ Converts the XML solrDoc to a Python dictionary.
        Pysolr.add requires a dictionary representation.
        """
        root = etree.fromstring(self.solrDoc())
        docs = [{f.attrib['name']: f.text
                for f in doc.iterfind('field[@name]')}
                for doc in root.iterfind('doc')]
        return docs
