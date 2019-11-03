import mutagen as mt
from pathlib import Path
import os


def has_ext_of(path, ext):
    """
    Returns True, if path has extension ext, case and leading dot insensitive.
    """
    return path.suffix.lstrip(".").upper() == ext.lstrip(".").upper()


def is_audiofile(path, file_type):
    p = Path(path.decode())
    t = file_type.decode()

    return is_audiofile_internal(p, t)


def is_audiofile_internal(path, file_type):
    if not path.is_file(): return False
    if mt.File(path, easy=True):
        if len(file_type) == 0 or has_ext_of(path, file_type):
            return True

    return False


def audiofiles_count(directory, file_type):
    """
    Returns full recursive count of audiofiles in directory.
    """
    cnt = 0
    p = directory.decode()
    t = file_type.decode()

    for root, dirs, files in os.walk(p):
        for name in files:
            if is_audiofile_internal(Path(root).joinpath(name), t):
                cnt += 1
    return cnt


def set_tags(path, tags):
    p = path.decode()
    audio = mt.File(p, easy=True)
    if audio is None: return False

    for x in tags:
        audio[x[0].decode()] = x[1].decode()

    audio.save()
    return True
