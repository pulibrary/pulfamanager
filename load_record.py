#!./venv/bin/python

from folders import Folder
from collection import Collection
from names import Name
import argparse


class Proxy:
    def __init__(self, subject):
        self.subject = subject

    def load(self):
        self.subject.post_to_exist()


class ProxyCollection(Proxy):
    def load(self):
        self.subject.post_to_exist()
        self.subject.add_to_solr()


class Doer:
    def __init__(self, path):
        self.path = path

    def resource(self, path):
        if path.endswith('.EAD.xml'):
            return ProxyCollection(Collection(path))
        elif path.endswith('CPF.xml'):
            return Proxy(Name(path))
        elif path.endswith('mets'):
            return Proxy(Folder(path))
        else:
            raise ValueError

    def load(self):
        self.resource(self.path).load()


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('path',
                        help='path to record or directory')
    args = parser.parse_args()
    print(args.path)
    if args.path:
        doer = Doer(args.path)
        doer.load()
