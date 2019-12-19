#!/bin/bash

#SBATCH --time=72:00:00   # walltime
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks=24   # number of processor cores (i.e. tasks)
#SBATCH --mem-per-cpu=8G   # memory per CPU core
#SBATCH -J "InterSNP" # job name
#SBATCH --mail-user=david_jarvis@byu.edu   # email address
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

module purge
module load compiler_gnu/6.4
module load bambam/1.4

interSnp -r /fslhome/dj58/fsl_groups/fslg_pws670/compute/pws670_jarvis/pilon/jelly.out.pilon.fasta.fasta -w m6f35.hapmap -m 6 -f 0.35 -t 24 *.bam.sort.bam > SNP_Calling_m6_f35.snp

