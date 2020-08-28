#!/bin/bash
# dlw August 2020

#SBATCH --job-name=replicates20k
#SBATCH --output=replicates.out
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --time=0-8:00:00
#SBATCH --nodelist=c[4]


SEED=1134
SNAME="gurobi_persistent"

LOC="../../../mpisppy/examples/farmer"

CROPSMULT=1000
SCENCNT=3

export GRB_LICENSE_FILE=/home/dlwoodruff/software/gurobi900/licenses/c4/gurobi.lic


for REPL in 1 2 3 4 5
  do
    echo "=========="
    let NP=3*${SCENCNT}
    mpiexec --oversubscribe -np ${NP} python -m mpi4py ${LOC}/farmer_cylinders.py ${SCENCNT} --bundles-per-rank=0 --max-iterations=100 --rel-gap=0.0001 --with-xhatshuffle --default-rho=0.1 --seed=${SEED} --solver-name=$SNAME --crops-mult=${CROPSMULT} --no-fwph --max-solver-threads=1 >& replicate_${REPL}.out
  done
