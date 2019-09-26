import re
import collection
from pysolr import Solr
import logging

logging.basicConfig(level=logging.DEBUG)


class TestCollection:

    def setup(self):
        pathtofixtures = "./fixtures/eads"
        smallead = "LAE003.EAD.xml"
        path = '/'.join((pathtofixtures, smallead))
        self.testee = collection.Collection(path)

    def test_validity(self):
        assert(self.testee.isvalid())

    def test_solrDoc(self):
        doc = self.testee.solrDoc()
        assert(re.search('Guatemala', doc) is not None)

    def test_solr_delete_query(self):
        """Be sure the colon in http:// has been escaped"""
        q = self.testee.solr_delete_query()
        assert(re.search('LAE003', q) is not None)
        assert(re.search('\\:', q) is not None)

    def test_solr_core_connection(self):
        conn = self.testee.solr_core_connection('pulfa0')
        assert(isinstance(conn, Solr))

    def test_post_to_exist(self):
        assert(self.testee.post_to_exist()[0] == 201)
