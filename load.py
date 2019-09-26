#!/usr/bin/env python3

from loader import CollectionLoader, NameLoader, FolderLoader
import logging


def main():
    logging.basicConfig(level=logging.INFO,
                        format='%(asctime)s %(message)s',
                        filename='load.log')
    logging.info('Pulfa update started')

    collections = CollectionLoader()

#    for service in [collections, names, folders]:
    for service in [collections]:
        service.svn_update()
        service.load_resources()

    logging.info('Pulfa update finished')


if __name__ == '__main__':
    main()
