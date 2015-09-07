# #!/usr/bin/env bash
set -e 
mkdir ../data
cd ../data
echo $PWD
curl -O http://www.astro.washington.edu/users/lynnej/opsim/ops2_1114_sqlite.db
curl -O http://www.astro.washington.edu/users/lynnej/opsim/enigma_1189_sqlite.db.gz
gunzip *.gz
cd ../science/Transients
ln -s ../data/*.db


