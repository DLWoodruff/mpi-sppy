#!/bin/bash
# dlw August 2020

#SBATCH --job-name=morespokes20k
#SBATCH --output=morespokes20k.out
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=0-1:00:00
#SBATCH --nodelist=c[4]


SEED=1134
SNAME="gurobi_persistent"

LOC="../../../mpisppy/examples/farmer"

CROPSMULT=1000
export GRB_LICENSE_FILE=/home/dlwoodruff/software/gurobi900/licenses/c4/gurobi.lic

rm *.csv

# there are two spokes to start with...
for EBC in 6 2 0
  do
    let NP=3+${EBC}

    for SCENCNT in 8 4
      do
        echo "*========="
        mpiexec --oversubscribe -np ${NP} python -m mpi4py ${LOC}/farmer_morespokes.py ${SCENCNT} --bundles-per-rank=0 --max-iterations=100 --rel-gap=0.0 --with-xhatshuffle --default-rho=0.1 --seed=${SEED} --solver-name=$SNAME --crops-mult=${CROPSMULT} --no-fwph --max-solver-threads=1 --extra-bound-cnt=${EBC} >& morespokes_${EBC}_${SCENCNT}.out
      done
  done

        #python ${LOC}/farmer_ef.py ${CROPSMULT} ${SCENCNT} ${SNAME}
# with multiple xhatters, you can't have a trace unless you work harder at it
