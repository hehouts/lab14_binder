# source https://sourmash.readthedocs.io/en/latest/tutorial-lemonade.html

cd ~/sourmash

#downloads a GTDB genomic representatives database, containing ~65,000 genomes - that’s because it’s smaller than the full GTDB database
# 60 sec
curl -JLO https://osf.io/3a6gn/download

# downloads taxonomy spreadsheet
# 10 sec
curl -JLO https://osf.io/v3zmg/download

gunzip gtdb-rs207.taxonomy.csv.gz


# index the database
sourmash tax prepare -t gtdb-rs207.taxonomy.csv \
    -o gtdb-rs207.taxonomy.sqldb -F sql
    
# download a metagenome (comes in two parts)
# 60 sec
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR885/005/SRR8859675/SRR8859675_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR885/005/SRR8859675/SRR8859675_2.fastq.gz

# 1-2 minutes
sourmash sketch dna -p k=31,abund SRR8859675*.gz \
    -o SRR8859675.sig.gz --name SRR8859675
    
# ~ 6 min  
sourmash gather SRR8859675.sig.gz gtdb-rs207.genomic-reps.dna.k31.zip --save-matches matches.zip
    
    
