
## Go to trim directory
cd /data/trim/

## for every FASTQ
find /data/NoUMI/ -name "*_UMIext.fastq.gz" | while read SAMPLE

do

#Get the file name, without the path and file ending
FILEBASE=${SAMPLE%_UMIext.fastq.gz}
FILEBASE2=$(basename "${SAMPLE%_UMIext.fastq.gz}")

## Remove the adapter sequences, PolyA sequences and low base calling quality read segments
cutadapt -m 20 -O 20 -a "polyA=A{20}" -a "QUALITY=G{20}" -n 2 -o $FILEBASE.Atrim.fq.gz $SAMPLE 
cutadapt -m 20 -O 3 --nextseq-trim=10 -a "r1adapter=A{18}AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC;min_overlap=3;max_error_rate=0.100000" -o $FILEBASE.Atrim2.fq.gz  $FILEBASE.Atrim.fq.gz 
cutadapt -m 20 -O 20 -g "r1adapter=AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC;min_overlap=20" --discard-trimmed -o $FILEBASE2".trimed.fq.gz" $FILEBASE.Atrim2.fq.gz

#End loop
done
