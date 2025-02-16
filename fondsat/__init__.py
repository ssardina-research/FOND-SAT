#
# This file is part of fondsat.
#

"""Top-level package for fondsat."""
from .__version__ import (
    __author__,
    __author_email__,
    __copyright__,
    __description__,
    __license__,
    __title__,
    __url__,
    __version__,
)
from .utils.system import get_pkg_root

ROOT_PATH = get_pkg_root()
VERSION = __version__
