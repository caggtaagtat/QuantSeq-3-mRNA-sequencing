## Go to bam directory
cd /data/bam/

## For every BAM after duplicate removal
find /data/bam/deduplicatedBams/ -name "*deduplicated.bam" | while read SAMPLE

do

## Get the file name, without the path and file ending
FILEBASE=${SAMPLE%deduplicated.bam}
FILEBASE2=$(basename "${SAMPLE%deduplicated.bam}")

GTF=/data/bam/Fused_genome.gtf

## Genereate gene expression count matrix
featureCounts -s 1 -O -T 20 -a $GTF -o "/data/countMatrice/"$FILEBASE2"_featureCounts.txt" $SAMPLE

## End loop
done