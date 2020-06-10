#!./venv/bin/python

from loader import CollectionLoader, NameLoader, FolderLoader
import logging
import os
import io
import yaml
import datetime
from subprocess import Popen, PIPE
from pathlib import Path



def main():
    package_path = os.path.dirname(__file__)
    conf_file = os.path.join(package_path, 'conf.yaml')
    with io.open(conf_file, 'r') as fh:
        conf = yaml.load(fh, Loader=yaml.FullLoader)
    basename = ".".join((datetime.datetime.now().strftime("%Y-%m-%d"),
                         "manage", "log"))
    logfilepath = os.path.join(conf['logdir'], basename)

    logging.basicConfig(level=logging.INFO,
                        format='[%(asctime)s] %(levelname)s: %(message)s',
                        datefmt='%m/%d/%Y %I:%M:%S %p',
                        filename=logfilepath)

    if Path(conf['lockfile']).exists():
        logging.info(
            'Pulfa load not run; another update is already running.')
    else:
        lockfile = Path(conf['lockfile'])
        lockfile.touch()
        logging.info('Pulfa load started')

        collections = CollectionLoader()
        names = NameLoader()
        folders = FolderLoader()

        for service in [collections, names, folders]:
            if conf['logreaders'] and service.effort_estimate() > conf['warnlevel']:
                estimate = service.effort_estimate()
                logging.info("Pulfa load may take a long time; loading {estimate} records.".format(estimate))

            service.load_resources()

        logging.info('Pulfa load finished')
        lockfile.unlink()

if __name__ == '__main__':
    main()
