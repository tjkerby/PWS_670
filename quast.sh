#!/bin/bash

#SBATCH --time=72:00:00   # walltime
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --mem-per-cpu=65536M   # memory per CPU core
#SBATCH --mail-user={your email}   # email address
#SBATCH --mail-type=FAIL

//change filepaths

python /fslhome/emmakw/fsl_groups/fslg_pws670/bin/quast-5.0.2/quast.py -o quast.output -g  /fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/maker/Final_allscaffolds_functional_blast.gff /fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/maker/jelly.out.pilon.fasta.fa
