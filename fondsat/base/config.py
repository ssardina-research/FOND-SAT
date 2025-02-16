import os

from fondsat import ROOT_PATH

MINISAT_BIN = os.path.join(ROOT_PATH, "solvers", "minisat")
GLUCOSE_BIN = os.path.join(ROOT_PATH, "solvers", "glucose")
KISSAT_BIN = os.path.join(ROOT_PATH, "solvers", "kissat")

TRANSLATOR_BIN = os.path.join(ROOT_PATH, "translate", "translate.py")
FD_INV_LIMIT = 300

PYTHON_MINOR_VERSION = 8   # minimum python version required
