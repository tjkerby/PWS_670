#!bin/bash

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4G   # memory per CPU core
#SBATCH -J "bwa_mem"   # job name
#SBATCH --mail-user=emmakate.wilcox3@gmail.com   # email address
#SBATCH --mail-type=FAIL 

module purge                                           
module load conda-pws
#module load hisat2
module load conda/bwa_0.7.17
module load samtools/1.6
module load stringtie 
module load cufflinks/v2.2.1

#hisat2 -build -x /fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/jelly.out.pilon.fasta.fasta  hisat.index


samtools view -Sb --threads $T > $alignments/$name.bam && samtools sort --threads $T -o $alignments/$name.sorted.bam $alignments/$name.bam  && samtools index -@ $T $alignments/$name.sorted.bam


stringtie $alignments/$name.sorted.bam  [-l <label>] -o hisat_reference_pilon_jelly_out.gtf -p 8

stringtie --merge $alignments/$name.sorted.bam  [-l <label>] -o hisat_reference_pilon_jelly_out.gtf -p 8 

stringtie -e $alignments/$name.sorted.bam  [-l <label>] -o hisat_reference_pilon_jelly_out.gtf -p 8

cuffdiff -o -b -L -u 
