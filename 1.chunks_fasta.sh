#!/bin/bash

#SBATCH --time=1:00:00   # walltime
#SBATCH --ntasks=2   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4G   # memory per CPU core
#SBATCH --mail-user=emmakate.wilcox3@gmail.com  # email address
#SBATCH --mail-type=FAIL


#use this script to break up an assembly into smaller pieces - I use it with MAKER to parallelize the process of annotation.  There is a fasta_tool called split that will make separate files for each sequence in a fasta file.

module purge
module load conda-pws
module load maker_v2.31.10

fasta=/fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/MAKER/DATA/ordered_filtered_reference.maker.fasta
chunks=10 #number of chunks

fasta_tool --chunks ${chunks} ${fasta}
