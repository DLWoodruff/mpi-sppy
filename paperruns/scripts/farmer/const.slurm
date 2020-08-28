#!/bin/bash
# dlw August 2020

#SBATCH --job-name=20k
#SBATCH --output=phaph20k.out
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=0-8:00:00
#SBATCH --nodelist=c[4]


SEED=1134
SNAME="gurobi_persistent"

LOC="../../../mpisppy/examples/farmer"

CROPSMULT=1000
export GRB_LICENSE_FILE=/home/dlwoodruff/software/gurobi900/licenses/c4/gurobi.lic

rm *.csv

for SCENCNT in 8 4 2 1
  do
    echo "*========="
    let NP=3*${SCENCNT}
    #python ${LOC}/farmer_ef.py ${CROPSMULT} ${SCENCNT} ${SNAME}
    mpiexec --oversubscribe -np ${NP} python -m mpi4py ${LOC}/farmer_cylinders.py ${SCENCNT} --bundles-per-rank=0 --max-iterations=100 --rel-gap=0.0 --with-xhatshuffle --default-rho=0.1 --seed=${SEED} --solver-name=$SNAME --crops-mult=${CROPSMULT} --trace-prefix="nobun_${NP}_${SCENCNT}_${SEED}_"  --no-fwph --max-solver-threads=1 >& nobun_${SCENCNT}.out
    mv *.csv savecsv
  done
