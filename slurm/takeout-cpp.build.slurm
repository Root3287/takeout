#!/bin/bash
#SBATCH --time=00:10:00
#SBATCH --mem-per-cpu=2048
#SBATCH --job-name="takout-build-cpp"
#SBATCH --error=/work/cseos2g/tgibbons/takeout/data/job.%J.err
#SBATCH --out=/work/cseos2g/tgibbons/takeout/data/job.%J.out
#SBATCH --nodes=1

module load compiler/clang/18

PREMAKE5_DOWNLOAD=https://github.com/premake/premake-core/releases/download/v5.0.0-beta3/premake-5.0.0-beta3-linux.tar.gz
wget -qO premake5.tar.gz $PREMAKE5_DOWNLOAD
tar -xf premake5.tar.gz && chmod +x ./premake5

premake5 gmake2 cc=clang && make -C workspace config=release