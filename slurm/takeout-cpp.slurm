#!/bin/bash
#SBATCH --time=72:00:00
#SBATCH --mem-per-cpu=1024
#SBATCH --job-name="takout-cpp"
#SBATCH --error=/work/cseos2g/tgibbons/takeout/data/job.%J.err
#SBATCH --out=/work/cseos2g/tgibbons/takeout/data/job.%J.out
#SBATCH --nodes=2

export WDIR=/work/cseos2g/tgibbons/takeout

module load gnu-parallel/20220722
scontrol show hostnames > hostfile

export JOBS_PER_NODE=$(( $SLURM_CPUS_ON_NODE / $SLURM_CPU_PER_TASKS ))

parallel \\
	--jobs $JOBS_PER_NODE \\
	--slf hostfile \\
	--wd $WDIR \\
	--joblog $WDIR/data/task.joblog \\
	--resume \\
	--results $WDIR/data/takeout-cpp.csv \\
	parallel $WDIR/bin/Release/linux-x86_64/takeout -w {1} -t {2} -g {3} -c {4} -o {5} ::: $(seq 10 5 60) ::: $(seq 5 5 200) ::: $(seq 0 5 500) ::: $(seq 0 0.08334 4) ::: $(seq 0 0.08334 1)