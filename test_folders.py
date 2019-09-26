from os import path
import folders


class TestFolders:
    pathtofixtures = "./fixtures/mets"
    folder1 = "AC003/c011.mets"

    def setup(self):
        self.subject = folders.Folder(
            path.join(self.pathtofixtures, self.folder1))

    def test_service(self):
        assert(self.subject.service == 'folders')

    def test_db_subpath(self):
        assert(self.subject.db_subpath() == self.folder1)

    def test_exist(self):
        assert(self.subject.post_to_exist()[0] == 201)
