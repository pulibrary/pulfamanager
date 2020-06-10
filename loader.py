import sys
import os
import io
import logging
from collection import Collection
from names import Name
from folders import Folder
import yaml
from subprocess import run


class Loader:
    conf_file = os.path.join(os.path.dirname(__file__), 'conf.yaml')

    def __init__(self):
        with io.open(self.conf_file, 'r') as fh:
            conf = yaml.load(fh, Loader=yaml.FullLoader)
            self.ead_data_dir = conf['data']['ead_home']
            self.eac_data_dir = conf['data']['eac_home']
            self.mets_data_dir = conf['data']['mets_home']
            self.timestamp = conf['timestamp']

    def timestamp_file(self):
        return os.path.join(self.data_dir, self.timestamp)

    def last_load_time(self):
        try:
            return os.stat(self.timestamp_file()).st_mtime
        except OSError:
            None

    def update_timestamp(self):
        """ Equivalent of 'touching' the timestamp file.
        """
        with open(self.timestamp_file(), 'a'):
            os.utime(self.timestamp_file(), None)

    def svn_update(self):
        '''run svn update in the class's data_dir.'''
        run(["svn", "update", self.data_dir])

    def load_resources(self):
        """Load resources for first time, or afresh."""
        self.do_update_resources(load_all=True)
        self.update_timestamp()

    def update_resources(self):
        """Update resources and reset timestamp."""
        if self.last_load_time():
            self.do_update_resources(load_all=False)
            self.update_timestamp()

    def file_outdated(self, root, fname):
        f_mtime = os.stat(os.path.join(root, fname)).st_mtime
        lasttime = self.last_load_time()
        status = f_mtime > lasttime
        return status

    def should_process_file(self, root, fname, load_all=False):
        logging.info("load_all is {}.".format(load_all))
        status = (self.is_right_kind(fname) and
                  (load_all or (self.file_outdated(root, fname))))
        logging.info("returning status {}".format(status))
        return status

    def effort_estimate(self):
        fileset = []
        for root, dirs, files in os.walk(self.data_dir):
            for fname in files:
                if self.should_process_file(root, fname):
                    fileset.append(fname)
                    if '.svn' in dirs:
                        dirs.remove('.svn')
        return len(fileset)

    def do_update_resources(self, load_all):
        for root, dirs, files in os.walk(self.data_dir):
            for fname in files:
                if self.should_process_file(root, fname, load_all):
                    try:
                        logging.info('updating ' + fname)
                        resource = self.resource(os.path.join(root, fname))
                        resource.update()
                    except Exception:
                        e = sys.exc_info()[0]
                        logging.error('an error occured; ' +
                                      fname + ' not updated.' + e)

                    if '.svn' in dirs:
                        dirs.remove('.svn')


class CollectionLoader(Loader):
    def __init__(self):
        Loader.__init__(self)
        self.data_dir = self.ead_data_dir

    def is_right_kind(self, fname):
        status = fname.endswith('.EAD.xml')
        return status

    def resource(self, path):
        return Collection(path)


class NameLoader(Loader):
    def __init__(self):
        Loader.__init__(self)
        self.data_dir = self.eac_data_dir

    def is_right_kind(self, fname):
        return fname.endswith('CPF.xml')

    def resource(self, path):
        return Name(path)


class FolderLoader(Loader):
    def __init__(self):
        Loader.__init__(self)
        self.data_dir = self.mets_data_dir

    def is_right_kind(self, fname):
        return fname.endswith('.mets')

    def resource(self, path):
        return Folder(path)
