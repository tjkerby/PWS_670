#!/bin/bash

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=2048M   # memory per CPU core
#SBATCH -J "functional"   # job name
#SBATCH --mail-user=emmakate.wilcox3@gmail.com   # email address
#SBATCH --mail-type=FAIL

data_dir=/fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/maker/DATA

module purge
module load conda-pws
module load maker_v2.31.10

maker_functional_gff ${data_dir}/uniprot_sprot.fasta maker2uni.blasp Final_allscaffolds.gff > Final_allscaffolds_functional_blast.gff && perl AED_cdf_generator.pl -b 0.025 Final_allscaffolds_functional_blast.gff > AED_table.txt

maker_functional_fasta ${data_dir}/uniprot_sprot.fasta maker2uni.blasp Final_allscaffolds.all.maker.proteins.fasta > Final_allscaffolds.all.maker.proteins_functional_blast.fasta

maker_functional_fasta ${data_dir}/uniprot_sprot.fasta maker2uni.blasp Final_allscaffolds.all.maker.transcripts.fasta > Final_allscaffolds.all.maker.transcripts_functional_blast.fasta
