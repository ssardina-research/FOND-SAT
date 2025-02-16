import os

# Append the folder of this script to Python path so that planner can be run from anywhere
# TODO: seems not needed anymore as Python adds the script dir by default!!
DIR = os.path.dirname(os.path.realpath(__file__))
# sys.path.append(DIR)

MINISAT_BIN = os.path.join(DIR, "solvers", "minisat")
GLUCOSE_BIN = os.path.join(DIR, "solvers", "glucose")
KISSAT_BIN = os.path.join(DIR, "solvers", "kissat")


CLINGO_BIN = "clingo"
DETERMINISER_BIN = "fond-utils" # not really used anymore, used via library API
TRANSLATOR_BIN = "translate.py"

FD_INV_LIMIT = 300

PYTHON_MINOR_VERSION = 10   # minimum python version required
