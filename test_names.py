import names
from os import path
import re
from pysolr import Solr


class TestNames:
    def setup(self):
        pathtofixtures = "./fixtures/eacs"
        eac1 = "WORDSWORTH_WILLIAM_17701850.CPF.xml"
        self.subject = names.Name(path.join(pathtofixtures, eac1))

    def test_solrDoc(self):
        doc = self.subject.solrDoc()
        assert(re.search('Wordsworth', doc) is not None)

    def test_solr_delete_query(self):
        q = self.subject.solr_delete_query()
        assert(q == 'id:f95240cf3ec3fe4908ae19c0dcde2bf6')

    def test_solr_core_connection(self):
        conn = self.subject.solr_core_connection('pulfa0')
        assert(isinstance(conn, Solr))
