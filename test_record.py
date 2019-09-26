import record
import os


class TestRecord:

    def setup(self):
        self.subject = record.Record('boguspath')

    def test_conf(self):
        assert(self.subject.baseURI) == 'https://findingaids-dev.princeton.edu'
        assert(self.subject.enhancer) == os.path.join(
            os.path.dirname(__file__),
            'ead-enhanced.xsl')
        assert(self.subject.collectionXSLT) == os.path.join(
            os.path.dirname(__file__),
            'collection2solr.xsl')
        assert(self.subject.nameXSLT) == os.path.join(
            os.path.dirname(__file__),
            'name2solr.xsl')
