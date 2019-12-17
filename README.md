# PWS_670



Assemblathon Stats

This program is used to analyze basic contig and scaffold level statistics. Assemblathon Stats gives you the following information in the analysis: 

Number of scaffolds, Total size of scaffolds, Total scaffold length as percentage of known genome size, Longest scaffold, Shortest scaffold, Number of scaffolds > 500, Number of scaffolds > 1K, Number of scaffolds > 10K, Number of scaffolds > 100K, Number of scaffolds > 1M, Mean scaffold size, Median scaffold size, N50 scaffold length, L50 scaffold count, N50 scaffold - NG50 scaffold length difference, scaffold %A, scaffold %C, scaffold %G, scaffold %T, scaffold %N, scaffold N, scaffold %non-ACGTN, Number of scaffold non-ACGTN, Percentage of assembly in scaffolded contigs, Percentage of assembly in unscaffolded contigs, Average number of contigs per scaffold, Average length of breaks (20 or more Ns) between contigs, Number of contigs, Number of contigs in scaffolds, Number of contigs not in scaffolds, Total size of contigs, Longest contig, Shortest contig, Number of contigs > 500, Number of contigs > 1K, Number of contigs > 10K, Number of contigs > 100K, Number of contigs > 1M, Mean contig size, Median contig size, N50 contig length, L50 contig count, N50 contig - NG50 contig length difference, contig %A, contig %C, contig %G, contig %T, contig %N, contig N, contig % non-ACGTN, and Number of contig non-ACGTN.

Usage: assemblathon_stats.pl <assembly_file>

	Options: -limit <int>   limit analysis to first <int> sequences (useful for testing)
       		 -size <float>  genome size is <float> Mbp (million bases)
        	 -csv           produce a CSV output file of all results
        	 -graph         produce a CSV output file of NG(X) values (NG1 through to NG99), suitable for graphing
        	 -n <int>       specify how many consecutive N characters should be used to split scaffolds into contigs
		
Two ways to access assemblathon2-analysis program:
1.	Wget https://github.com/ucdavis-bioinformatics/assemblathon2-analysis.git
2.	Access fulton supercomputing lab; load module with following commands ‘module load conda-pws’ and ‘module load assemblathon_stats’


Assembly Stats

This program is to analyze basic data about your fasta/fastq files. Assembly Stats gives you the following information about your fasta/fastq files: 

 Sum = (number of nucleotides contained within your file/files), n = (number of contigs/files), ave = (average size of contigs or files), largest = (largest contig/file size, N50 = (N50 of your Fasta/fastq files), N60 = (N60 of your Fasta/fastq files), N70 = (N70 of your Fasta/fastq files), N80 = (N80 of your Fasta/fastq files), N90 = (N90 of your Fasta/fastq files), N100 = (N100 of your Fasta/fastq files), N_count = (N count), Gaps = (number of any run of Ns of any length)
 
usage: stats [options] <list of fasta/q files>

Reports sequence length statistics from fasta and/or fastq files

options:
-l <int> Minimum length cutoff for each sequence.
        Sequences shorter than the cutoff will be ignored [1]
-s	Print 'grep friendly' output
-t	Print tab-delimited output
-u	Print tab-delimited output with no header line
-v	Print version and exit

Two ways to access assemblathon2-analysis program:
1.	Wget https://github.com/sanger-pathogens/assembly-stats.git
2.	- Access fulton supercomputing lab; load module with following commands ‘module load conda-pws’ and ‘module load assembly-stats’
