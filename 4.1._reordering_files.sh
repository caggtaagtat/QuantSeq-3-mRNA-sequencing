
## Go to bam directory
cd /data/bam/

## Save all BAM files in new directory 
mkdir BAM_files

## For every STAR output directory in your STAR directory
for i in /data/bam/*.STAR

#Do the following
do

#Enter the new directory
cd $i

b=$(basename "${i%.STAR}")

## Access files and copy them to new directory
cp Aligned.sortedByCoord.out.bam /data/bam/BAM_files/$b.bam


done

