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
            'Pulfa update not run; another update is already running.')
    else:
        lockfile = Path(conf['lockfile'])
        lockfile.touch()
        logging.info('Pulfa update started')

        collections = CollectionLoader()
        names = NameLoader()
        folders = FolderLoader()

        for service in [collections, names, folders]:
            service.svn_update()
            if conf['logreaders'] and service.effort_estimate() > conf['warnlevel']:
                estimate = service.effort_estimate()
                p1 = Popen(["echo",
                            "pulfa update may take a long time; loading {estimate} records".format(estimate)],
                           stdout=PIPE)
                p2 = Popen(["mail", "-s", "update report",
                            conf['logreaders']], stdin=p1.stdout)
                p1.stdout.close()
                outs, errs = p2.communicate()

            service.update_resources()

        logging.info('Pulfa update finished')
        lockfile.unlink()

    if conf['logreaders']:
        p1 = Popen(["cat", logfilepath], stdout=PIPE)
        p2 = Popen(["mail", "-s", "update report",
                    conf['logreaders']], stdin=p1.stdout)
        p1.stdout.close()
        outs, errs = p2.communicate()


if __name__ == '__main__':
    main()
