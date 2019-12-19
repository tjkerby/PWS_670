#bin/bash/

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=4G   # memory per CPU core
#SBATCH -J "bwa_mem"   # job name
#SBATCH --mail-user={your email}   # email address
#SBATCH --mail-type=FAIL

module purge
module load conda-pws
module load hisat2

hisat2 -build -x /fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/jelly.out.pilon.fasta.fasta  hisat.index

hisat2 -x /fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/jelly.out.pilon.fasta.fasta  -U ./Trimmed_Reads/flower1_rep2_SRX1796739_trimmed.fastq,./Trimmed_Reads/germinating_seedlings1_rep1_SRX1796773_trimmed,./Trimmed_Reads/mature_leaf_rep2_SRX1796284_trimmed.ftq,./Trimmed_Reads/root_rep2_SRX1796260_trimmed.fastq  -S jelly.pilon.fasta.hisat.reference.sam  
