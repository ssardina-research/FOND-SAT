# FOND-SAT: A SAT-based FOND planning system for compact controllers

FOND solver based on SAT, as per the following paper:

* Tomas Geffner, Hector Geffner: [Compact Policies for Fully Observable Non-Deterministic Planning as SAT](https://arxiv.org/pdf/1806.09455.pdf). ICAPS 2018: 88-96

## Planner setup & pre-requisites

### Files

* `F-domains/` contains the FOND domains used. A more complete set of FOND problems can be found at [fond-domains](https://github.com/AI-Planning/fond-domains/) repo
* `fondsat/` contains the code for the FOND solver, including pre-compiled version of SAT solvers
  * `fondsat/translate` contains the the translator (SAS encoding + all-outcome determinization) from [PRP](https://github.com/QuMuLab/planner-for-relevant-policies).

### Install

The planner is distributed as a package and can then be installed via pip from the repo directly as follows:

```shell
$ pip install git+https://github.com/tomasgeffner/FOND-SAT
```

Alternatively, one can clone first and install the planner:

```shell
$ git clone https://github.com/tomasgeffner/FOND-SAT
$ cd fond-sat
$ pip install .
```

### SAT solvers

Two SAT solvers are already provided: [MiniSat](https://github.com/master-keying/minisat/) (default) and [Glucose](https://www.labri.fr/perso/lsimon/glucose/).

For easiness to use, binary Linux version of both are packaged in FOND-SAT (folder `fondsat/solvers/`). The version of MiniSAT has been obtained (and compiled) from [master-keying/minisat](https://github.com/master-keying/minisat/), which is a much more maintained repo than the one in the [original site](http://minisat.se/).

To add a new solver:

1. Add a new choice for option `--solver`.
2. Modify `main.py` to account for the new solver and define the corresponding `command` for it.
3. Provide the adequate `parseOutput()` function in `fondsat/CNF.py` to parse the output of the solver used.
4. Add the binary solver in folder `fondsat/solvers/`.

## Running the planner

The planner is offered as a binary application if the planner has been installed as a package via pip:

```shell
$ fondsat [OPTIONS] fond_domain fond_problem
```

Use `-h` to get all options available.

Note this is equivalent to cloning the planner repo and from its root folder execute:

```shell
$ python -m fondsat [OPTIONS] fond_domain fond_problem
 ```

An easy/quick solvable run would be:

```shell
$ python -m fondsat F-domains/islands/domain.pddl F-domains/islands/p03.pddl --solver glucose --tmp

# if already installed as package
$ fondsat F-domains/islands/domain.pddl F-domains/islands/p03.pddl --solver glucose --tmp
```

This would run the solver for the task 03 of the Islands domain, using Glucose as SAT solver and leaving behind the temporary files.

A more challenging ask (taking around 500secs/8min and using 10 states) would be:

```shell
$ fondsat F-domains/islands/domain.pddl F-domains/islands/p47.pddl --solver glucose

....
s SATISFIABLE
SAT
Done solver. Round time: 12.916486
Cumulated solver time: 39.73258573602652
PLANFOUND!
Elapsed total time (s): 501.258223
Elapsed initialisation time (s): 6.977923776998068
Elapsed grounding time (s): 442.8925411340024
Elapsed grounding time (s): [22.89034552499652, 30.071642617011094, 44.89836094499333, 47.62225245599984, 57.385479142991244, 62.35428485700686, 73.23855525600084, 104.43162033500266]
Elapsed solver time (s): 39.732586
Elapsed solver time (s): [2.222133905001101, 1.909849037998356, 3.3073226740089012, 3.8610715660033748, 3.949099778008531, 4.780444735995843, 6.786178249007207, 12.916485790003208]
Elapsed result output time (s): 0.00218252201739233
Elapsed result output time (s): [0.00031191699963528663, 0.0002279759937664494, 0.0005103060102555901, 0.0004846640076721087, 0.0002168909995816648, 0.00019257400708738714, 0.00023819399939384311]
Looking for strong plans: False
Fair actions: True
Done
```

It found a policy with 10 states. So, if we directly start with 10 states we should get a single SAT iteration that is shorter:

```shell
$ fondsat F-domains/islands/domain.pddl F-domains/islands/p47.pddl --start 10 --solver glucose

...
s SATISFIABLE
SAT
Done solver. Round time: 6.986108
Cumulated solver time: 6.9861076709930785
PLANFOUND!
Number of controller states: 12
Elapsed total time (s): 57.583673
Elapsed initialisation time (s): 2.3045000990387052
Elapsed grounding time (s): 40.83439256902784
Elapsed grounding time (s): [40.83439256902784]
Elapsed solver time (s): 6.986108
Elapsed solver time (s): [6.9861076709930785]
Elapsed result output time (s): 0
Elapsed result output time (s): []
Looking for strong plans: False
Fair actions: True
Done
```

Let's try the same but with MiniSAT:

```shell
$ fondsat F-domains/islands/domain.pddl F-domains/islands/p47.pddl --start 10 --solver minisat

...

SATISFIABLE
Done solver. Round time: 37.664106
Cumulated solver time: 37.6641057980014
PLANFOUND!
Number of controller states: 12
Elapsed total time (s): 87.636747
Elapsed initialisation time (s): 2.421148548950441
Elapsed grounding time (s): 39.97268579399679
Elapsed grounding time (s): [39.97268579399679]
Elapsed solver time (s): 37.664106
Elapsed solver time (s): [37.6641057980014]
Elapsed result output time (s): 0
Elapsed result output time (s): []
Looking for strong plans: False
Fair actions: True
Done
```

As one can see, using glucose seems to be much faster than using minisat (7s vs 37s).

Finally, if we tell FOND-SAT to try between 6 and 8 states, the planner will not find any solution;

```shell
$ fondsat F-domains/islands/domain.pddl F-domains/islands/p47.pddl --start 6 --end 8 --solver glucose

...
s UNSATISFIABLE
Done solver. Round time: 6.254708
Cumulated solver time: 10.737754994013812
UNSATISFIABLE
Elapsed total time (s): 165.802070
Elapsed initialisation time (s): 6.196163825006806
Elapsed grounding time (s): 148.8676775389904
Elapsed grounding time (s): [81.95103869499872, 66.91663884399168]
Elapsed solver time (s): 10.737755
Elapsed solver time (s): [4.483046648005256, 6.254708346008556]
Elapsed result output time (s): 0.0004607840091921389
Elapsed result output time (s): [0.000187127006938681, 0.0002736570022534579]
Looking for strong plans: False
Fair actions: True
Done
```

## Interpreting the policy

The policy displayed has 4 sections:

* `Atom (CS)`: For each controller state `CS` it prints out which atoms are true.
* `(CS, Action with arguments)`: For each controller state `CS`, it prints what actions are applied in it.
* `(CS, Action name, CS)`: For each controller state `CS`, it prints the action applied in that state (without arguments, for action with arguments check second section) and successor `CS`.
* `(CS1, CS2)`: The controller can evolve from `CS1` to `CS`. In other words, the action applied in `CS1` may lead to controller state `CS2`.

## Dual FOND planning

The paper talks about what we call *Dual FOND planning*. Dual FOND problems are those in which some actions are *fair* and some are *unfair*. To set some action (or actions) as unfair, add `_unfair_` as the last part of the action name in the *pddl* file. The planner will then set this action as unfair.