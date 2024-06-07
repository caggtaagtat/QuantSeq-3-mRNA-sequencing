## Go to directory
cd /data/

## for every fastq.gz file
find /data/raw/ -name "*.fastq.gz" | while read SAMPLE

do

## Get the file name, without the path and file ending
FILEBASE=${SAMPLE%_R1_001.fastq.gz}
FILEBASE2=$(basename "${SAMPLE%_R1_001.fastq.gz}")

## Trimm the UMI barcode and put it in read name
umi_tools extract --extract-method=regex --bc-pattern "(?P<umi_1>.{6})(?P<discard_1>.{4}).*" -L "/data/"$FILEBASE2".log" -I $SAMPLE -S $FILEBASE"_UMIext.fastq.gz" 

#End loop
done


