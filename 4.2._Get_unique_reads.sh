## Go to BAM_files directory
cd /data/bam/BAM_files/

## For every BAM file in folder
for i in *.bam

do

## Get only uniquely mapped reads 
samtools view -q 255 -b $i > $i.q255.bam

## Index new BAM file
samtools index $i.q255.bam $i.q255.bam.bai

## Get chromosome coverage per file
samtools idxstats $i.q255.bam > $i.stats

## Finish the Loop Action
done