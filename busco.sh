#!/bin/bash

#SBATCH --time=72:00:00   # walltime
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --mem-per-cpu=65536M   # memory per CPU core
#SBATCH --mail-user=emmakate.wilcox3@gmail.com   # email address
#SBATCH --mail-type=FAIL

module purge
module load conda-pws
module load python/3.7
module load busco

#Add full path to assembly
assembly=/fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/maker/Final_allscaffolds.all.maker.transcripts_functional_blast.fasta

#Add output name
output=busco.assembly.output

#Add species (rice or arabidopsis)
species=arabidopsis

#Add the mode (genome, proteins, transcriptome)
m=transcriptome

#Add the dataset (plants: embryophyta_odb10; liliopsida_odb10; solanaceae_odb10; eudicotyledons_odb10; look them up on https://busco.ezlab.org/)
l=~/fsl_groups/fslg_pws_module/software/.conda/envs/busco/datasets/embryophyta_odb10

run_BUSCO.py -i ${assembly} -o ${output}_${species} -l ${l} -m ${m} -c 1 -sp ${species} -f

