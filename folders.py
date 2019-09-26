"""Implements management of PULFA Folder records.
These are implemented as METS documents. Unlike
the other PULFA records, Folders are not indexed in
Solr; they are only maintained in eXist.
"""
from record import Record


class Folder(Record):
    def __init__(self, pathtorecord):
        Record.__init__(self, pathtorecord)
        self.service = "folders"

    def db_subpath(self):
        return '/'.join(self.recordPath.split('/')[-2:])
