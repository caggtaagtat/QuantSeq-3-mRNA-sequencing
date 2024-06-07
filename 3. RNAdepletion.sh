## Activate sortmerna conda enviroment
conda activate sortmerna_env

## Go to RNAfree directory
cd /data/RNAfree/


## For every trimemd fastq file
find /data/trim/ -name "*.trimed.fq.gz" | while read SAMPLE

do

## get file name, without endings
FILEBASE=$(basename "${SAMPLE%.trimed.fq.gz}")

R1=$SAMPLE

## Remove rRNA reads with sortmeRNA tool
echo "Running SortMeRNA for $FILEBASE"
sortmerna --ref /references/sortmernaRef/smr_v4.3_default_db.fasta --reads $SAMPLE --fastx --threads 10 --other "$FILEBASE.merged.fq" --workdir "/data/RNAfree/"$FILEBASE"/"

done 





