## Got to bam directory
cd /data/bam/

## Download reference files for toxoplasma and mouse
wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/release-58/protists/fasta/toxoplasma_gondii/dna/Toxoplasma_gondii.TGA4.dna.toplevel.fa.gz
wget https://ftp.ebi.ac.uk/ensemblgenomes/pub/release-58/protists/gtf/toxoplasma_gondii/Toxoplasma_gondii.TGA4.58.gtf.gz

wget https://ftp.ensembl.org/pub/release-111/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz
wget https://ftp.ensembl.org/pub/release-111/gtf/mus_musculus/Mus_musculus.GRCm39.111.gtf.gz

## Unzip references
gunzip *.gz

## Fuse mouse and toxoplasma genome
cat Toxoplasma_gondii.TGA4.dna.toplevel.fa Mus_musculus.GRCm39.dna.primary_assembly.fa > Fused_genome.fa
cat Toxoplasma_gondii.TGA4.58.gtf Mus_musculus.GRCm39.111.gtf > Fused_genome.gtf

## Clean up
rm Mus_musculus.GRCm39.111.gtf Mus_musculus.GRCm39.dna.primary_assembly.fa Toxoplasma_gondii.TGA4.58.gtf Toxoplasma_gondii.TGA4.dna.toplevel.fa

## Create genome Index with STAR
genomePath=/data/bam
genomDir=/data/bam/STARindexR100/

STAR --runThreadN 20 --runMode genomeGenerate --genomeDir $genomDir --genomeFastaFiles $genomePath"/Fused_genome.fa" --sjdbGTFfile $genomePath"/Fused_genome.gtf" --sjdbOverhang 99

## Split files for paralelle processing
find /data/RNAfree/ -name "*.merged.fq.fq.gz" | split -l 5


## Got to bam directory
cd /data/bam/

## Set paths for read alignment with STAR
genomePath=/data/bam
genomDir=/data/bam/STARindexR100/
gtfFile=$genomePath"/Fused_genome.gtf"

## For every FASTQ file, after trimming and rRNA removal
while read SAMPLE; do

## get file name without name endings
FILEBASE=$(basename "${SAMPLE%.merged.fq.fq.gz}")

## make new directory for the sample
mkdir /data/bam/$FILEBASE.STAR

## Define sample STAR output directory that was just created
outDIR=/data/bam/$FILEBASE.STAR/

## Enter the new directory
cd /data/bam/$FILEBASE.STAR


## align reads with STAR aligner against fused genome
STAR --outFilterType Normal --alignEndsType Local --runThreadN 20 --outSAMtype BAM SortedByCoordinate --alignSJDBoverhangMin 4 --alignIntronMax 300000 --alignSJoverhangMin 8 --genomeDir $genomDir --sjdbOverhang 99 --sjdbGTFfile $gtfFile --outFileNamePrefix $outDIR --readFilesIn $SAMPLE --readFilesCommand zcat

done < /data/bam/xaa