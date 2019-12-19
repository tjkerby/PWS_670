#!/bin/sh

mkdir ALLGFFS
mkdir ALLGFFS/scripts
mkdir ALLFASTAS
mkdir ALLFASTAS/scripts
 
for file in *.fasta
do
name=`echo $file | sed 's/.fasta//'`
cat > ./ALLGFFS/scripts/${name}.sh <<EOF
#!/bin/bash
#SBATCH -c 1 --qos=pws --mem=1gb -t 0:60:00
	 
module purge 
module load conda-pws
module load maker_v2.31.10

gff3_merge -d ./${name}.maker.output/${name}_master_datastore_index.log ${name}.all.gff -n
EOF

sbatch ./ALLGFFS/scripts/${name}.sh

cat > ./ALLFASTAS/scripts/${name}.sh <<EOF
#!/bin/bash

#SBATCH -c 1 --qos=pws --mem=1gb -t 0:10:00

module purge 
module load conda-pws
module load maker_v2.31.10

fasta_merge -d ./${name}.maker.output/${name}_master_datastore_index.log ${name}.all.maker.proteins.fasta ${name}.all.maker.transcripts.fasta ${name}.all.maker.snap_masked.proteins.fasta ${name}.all.maker.snap_masked.transcripts.fasta ${name}.all.maker.non_overlapping_ab_initio.proteins.fasta ${name}.all.maker.non_overlapping_ab_initio.transcripts.fasta
EOF

sbatch ./ALLFASTAS/scripts/${name}.sh
	 
done
