import os
import logging
import loader

logging.basicConfig(level=logging.DEBUG)


class TestLoader:
    test_data = os.path.join(
        os.path.dirname(__file__),
        'fixtures')


class TestCollectionLoader(TestLoader):
    def setup(self):
        self.subject = loader.CollectionLoader()
        self.subject.data_dir = os.path.join(self.test_data, 'eads')

    def test_conf(self):
        logging.debug('testing configuration')
        logging.debug('test data dir: {0}'.format(self.subject.data_dir))
        assert(self.subject.timestamp_file() == os.path.join(
            self.subject.data_dir, '.pulfa_last_load'))


class TestNameLoader(TestLoader):
    def setup(self):
        self.subject = loader.NameLoader()
        self.subject.data_dir = os.path.join(self.test_data, 'eacs')

    def test_conf(self):
        logging.debug('testing configuration')
        logging.debug('test data dir: {0}'.format(self.subject.data_dir))
        assert(self.subject.timestamp_file() == os.path.join(
            self.subject.data_dir, '.pulfa_last_load'))


class TestFolderLoader(TestLoader):
    def setup(self):
        self.subject = loader.FolderLoader()
        self.subject.data_dir = os.path.join(self.test_data, 'mets')

    def test_conf(self):
        logging.debug('testing configuration')
        logging.debug('test data dir: {0}'.format(self.subject.data_dir))
        assert(self.subject.timestamp_file() == os.path.join(
            self.subject.data_dir, '.pulfa_last_load'))
