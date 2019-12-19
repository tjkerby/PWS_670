#!/bin/bash

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=16   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=2048M   # memory per CPU core
#SBATCH -J "blastp"   # job name
#SBATCH --mail-user=emmakate.wilcox3@gmail.com   # email address
#SBATCH --mail-type=FAIL

module purge
module load conda-pws
module load maker_v2.31.10

#you need to make a blastdb for the uniprot_sprot.fasta.  GET the latest version from: ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz

data_dir=/fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/maker/DATA

makeblastdb -in ${data_dir}/uniprot_sprot.fasta -input_type fasta -dbtype prot && blastp -db ${data_dir}/uniprot_sprot.fasta -query Final_allscaffolds.all.maker.proteins.fasta -out maker2uni.blasp -evalue 0.000001 -outfmt 6 -num_alignments 1 -seg yes -soft_masking true -lcase_masking -max_hsps 1 -num_threads 16

