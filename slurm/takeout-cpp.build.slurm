#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=2048
#SBATCH --job-name="takeout-build-cpp"
#SBATCH --error=/work/cseos2g/tgibbons/takeout/data/job.%J.err
#SBATCH --out=/work/cseos2g/tgibbons/takeout/data/job.%J.out
#SBATCH --nodes=1

module load compiler/clang/18
module load make/4.3

# Build
make -C workspace config=release