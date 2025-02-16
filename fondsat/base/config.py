import os

from fondsat import ROOT_PATH

MINISAT_BIN = os.path.join(ROOT_PATH, "solvers", "minisat")
GLUCOSE_BIN = os.path.join(ROOT_PATH, "solvers", "glucose")
KISSAT_BIN = os.path.join(ROOT_PATH, "solvers", "kissat")


CLINGO_BIN = "clingo"
DETERMINISER_BIN = "fond-utils" # not really used anymore, used via library API
TRANSLATOR_BIN = "translate.py"

FD_INV_LIMIT = 300

PYTHON_MINOR_VERSION = 10   # minimum python version required
