#!/bin/sh

data_dir=/fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/maker/DATA
scripts_dir=/fslhome/emmakw/fsl_groups/fslg_pws670/compute/pws670_emma/annotate/maker

for file in *fasta
do
name=`echo $file | sed 's/.fasta//'`
mkdir ${scripts_dir}/${name}
cat > ${scripts_dir}/${name}/${name}.sh <<EOF
#!/bin/bash

#SBATCH --time=72:00:00   # walltime
#SBATCH --ntasks=8   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem-per-cpu=8G   # memory per CPU core
#SBATCH -J "maker"   # job name
#SBATCH --mail-user=emmakate.wilcox3@gmail.com   # email address
#SBATCH --mail-type=FAIL

module purge
module load conda-pws
module load maker_v2.31.10

maker -c 8 ${scripts_dir}/${name}/maker_opts.ctl ${scripts_dir}/${name}/maker_bopts.ctl ${scripts_dir}/${name}/maker_exe.ctl
EOF

cat > ${scripts_dir}/${name}/maker_exe.ctl <<EOF
#-----Location of Executables Used by MAKER/EVALUATOR
makeblastdb=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/makeblastdb #location of NCBI+ makeblastdb executable
blastn=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/blastn #location of NCBI+ blastn executable
blastx=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/blastx #location of NCBI+ blastx executable
tblastx=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/tblastx #location of NCBI+ tblastx executable
formatdb= #location of NCBI formatdb executable
blastall= #location of NCBI blastall executable
xdformat= #location of WUBLAST xdformat executable
blasta= #location of WUBLAST blasta executable
RepeatMasker=/fslgroup/fslg_pws_module/compute/.conda-pws/envs/repeatmasker_4.0.9_p2/bin/RepeatMasker #location of RepeatMasker executable
exonerate=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/exonerate #location of exonerate executable

#-----Ab-initio Gene Prediction Algorithms
snap=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/snap #location of snap executable
gmhmme3= #location of eukaryotic genemark executable
gmhmmp= #location of prokaryotic genemark executable
augustus=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/augustus #location of augustus executable
fgenesh= #location of fgenesh executable
tRNAscan-SE=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/tRNAscan-SE #location of trnascan executable
snoscan=/fslgroup/fslg_pws_module/compute/software/.conda/envs/maker_v2.31.10/bin/snoscan #location of snoscan executable

#-----Other Algorithms
probuild= #location of probuild executable (required for genemark)
EOF

cat > ${scripts_dir}/${name}/maker_bopts.ctl <<EOF
#-----BLAST and Exonerate Statistics Thresholds
blast_type=ncbi+ #set to 'ncbi+', 'ncbi' or 'wublast'

pcov_blastn=0.8 #Blastn Percent Coverage Threhold EST-Genome Alignments
pid_blastn=0.85 #Blastn Percent Identity Threshold EST-Genome Aligments
eval_blastn=1e-10 #Blastn eval cutoff
bit_blastn=40 #Blastn bit cutoff
depth_blastn=0 #Blastn depth cutoff (0 to disable cutoff)

pcov_blastx=0.5 #Blastx Percent Coverage Threhold Protein-Genome Alignments
pid_blastx=0.4 #Blastx Percent Identity Threshold Protein-Genome Aligments
eval_blastx=1e-06 #Blastx eval cutoff
bit_blastx=30 #Blastx bit cutoff
depth_blastx=0 #Blastx depth cutoff (0 to disable cutoff)

pcov_tblastx=0.8 #tBlastx Percent Coverage Threhold alt-EST-Genome Alignments
pid_tblastx=0.85 #tBlastx Percent Identity Threshold alt-EST-Genome Aligments
eval_tblastx=1e-10 #tBlastx eval cutoff
bit_tblastx=40 #tBlastx bit cutoff
depth_tblastx=0 #tBlastx depth cutoff (0 to disable cutoff)

pcov_rm_blastx=0.5 #Blastx Percent Coverage Threhold For Transposable Element Masking
pid_rm_blastx=0.4 #Blastx Percent Identity Threshold For Transposbale Element Masking
eval_rm_blastx=1e-06 #Blastx eval cutoff for transposable element masking
bit_rm_blastx=30 #Blastx bit cutoff for transposable element masking

ep_score_limit=20 #Exonerate protein percent of maximal score threshold
en_score_limit=20 #Exonerate nucleotide percent of maximal score threshold
EOF

cat > ${scripts_dir}/${name}/maker_opts.ctl <<EOF
#-----Genome (these are always required)
genome=${file} #genome sequence (fasta file or fasta embeded in GFF3 file)
organism_type=eukaryotic #eukaryotic or prokaryotic. Default is eukaryotic

#-----Re-annotation Using MAKER Derived GFF3
maker_gff= #MAKER derived GFF3 file
est_pass=0 #use ESTs in maker_gff: 1 = yes, 0 = no
altest_pass=0 #use alternate organism ESTs in maker_gff: 1 = yes, 0 = no
protein_pass=0 #use protein alignments in maker_gff: 1 = yes, 0 = no
rm_pass=0 #use repeats in maker_gff: 1 = yes, 0 = no
model_pass=0 #use gene models in maker_gff: 1 = yes, 0 = no
pred_pass=0 #use ab-initio predictions in maker_gff: 1 = yes, 0 = no
other_pass=0 #passthrough anyything else in maker_gff: 1 = yes, 0 = no

#-----EST Evidence (for best results provide a file for at least one)
est=${data_dir}/transcriptome.fasta #set of ESTs or assembled mRNA-seq in fasta format
altest=${data_dir}/Alyrata_384_v2.1.cds.fa #EST/cDNA sequence file in fasta format from an alternate organism
est_gff=
altest_gff= #aligned ESTs from a closly relate species in GFF3 format

#-----Protein Homology Evidence (for best results provide a file for at least one)
protein=${data_dir}/uniprot_sprot.fasta,${data_dir}/Alyrata_384_v2.1.protein.fa #protein sequence file in fasta format (i.e. from mutiple oransisms)
protein_gff=  #aligned protein homology evidence from an external GFF3 file

#-----Repeat Masking (leave values blank to skip repeat masking)
model_org= #select a model organism for RepBase masking in RepeatMasker
rmlib=${data_dir}/consensi.fa.classified #provide an organism specific repeat library in fasta format for RepeatMasker
repeat_protein=${data_dir}/te_proteins.fa #provide a fasta file of transposable element proteins for RepeatRunner
rm_gff= #pre-identified repeat elements from an external GFF3 file
prok_rm=0 #forces MAKER to repeatmask prokaryotes (no reason to change this), 1 = yes, 0 = no
softmask=1 #use soft-masking rather than hard-masking in BLAST (i.e. seg and dust filtering)

#-----Gene Prediction
snaphmm=/panfs/pan.fsl.byu.edu/scr/grp/fslg_pws_module/software/.conda/envs/maker_v2.31.10/share/snap/HMM/A.thaliana.hmm #SNAP HMM file
gmhmm= #GeneMark HMM file
augustus_species=arabidopsis #Augustus gene prediction species model
fgenesh_par_file= #FGENESH parameter file
pred_gff= #ab-initio predictions from an external GFF3 file
model_gff= #annotated gene models from an external GFF3 file (annotation pass-through)
est2genome=1 #infer gene predictions directly from ESTs, 1 = yes, 0 = no
protein2genome=1 #infer predictions from protein homology, 1 = yes, 0 = no
trna=1 #find tRNAs with tRNAscan, 1 = yes, 0 = no
snoscan_rrna= #rRNA file to have Snoscan find snoRNAs
unmask=0 #also run ab-initio prediction programs on unmasked sequence, 1 = yes, 0 = no

#-----Other Annotation Feature Types (features MAKER doesn't recognize)
other_gff= #extra features to pass-through to final MAKER generated GFF3 file

#-----External Application Behavior Options
alt_peptide=C #amino acid used to replace non-standard amino acids in BLAST databases
cpus=8 #max number of cpus to use in BLAST and RepeatMasker (not for MPI, leave 1 when using MPI)

#-----MAKER Behavior Options
max_dna_len=100000 #length for dividing up contigs into chunks (increases/decreases memory usage)
min_contig=1000 #skip genome contigs below this length (under 10kb are often useless)

pred_flank=200 #flank for extending evidence clusters sent to gene predictors
pred_stats=0 #report AED and QI statistics for all predictions as well as models
AED_threshold=1 #Maximum Annotation Edit Distance allowed (bound by 0 and 1)
min_protein=0 #require at least this many amino acids in predicted proteins
alt_splice=0 #Take extra steps to try and find alternative splicing, 1 = yes, 0 = no
always_complete=0 #extra steps to force start and stop codons, 1 = yes, 0 = no
map_forward=0 #map names and attributes forward from old GFF3 genes, 1 = yes, 0 = no
keep_preds=0 #Concordance threshold to add unsupported gene prediction (bound by 0 and 1)

split_hit=10000 #length for the splitting of hits (expected max intron size for evidence alignments)
single_exon=1 #consider single exon EST evidence when generating annotations, 1 = yes, 0 = no
single_length=250 #min length required for single exon ESTs if 'single_exon is enabled'
correct_est_fusion=0 #limits use of ESTs in annotation to avoid fusion genes

tries=2 #number of times to try a contig if there is a failure for some reason
clean_try=1 #remove all data from previous run before retrying, 1 = yes, 0 = no
clean_up=0 #removes theVoid directory with individual analysis files, 1 = yes, 0 = no
TMP= #specify a directory other than the system default temporary directory for temporary files
EOF

sbatch ${scripts_dir}/${name}/${name}.sh

done

