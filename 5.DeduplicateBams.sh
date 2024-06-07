## Go to bam directory
cd /data/bam/

mkdir deduplicatedBams

## For every filtered BAM file
find /data/bam/BAM_files/ -name "*.bam.q255.bam" | while read SAMPLE

do

## Get the file name, without the path and file ending
FILEBASE=${SAMPLE%.bam.q255.bam}
FILEBASE2=$(basename "${SAMPLE%.bam.q255.bam}")

## Remove duplicated reads with very similar read UMIs and very similar mapping coordinates on the reference genome
umi_tools dedup -I $SAMPLE --output-stats=deduplicated -S "/data/bam/deduplicatedBams/"$FILEBASE2"deduplicated.bam" 

done