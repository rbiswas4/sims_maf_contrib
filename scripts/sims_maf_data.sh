# #!/usr/bin/env bash
set -e 
echo 'Make data directory'
echo $PWD
mkdir ../data
cd ../data
echo 'The data directory is'
echo $PWD
curl -O http://www.astro.washington.edu/users/lynnej/opsim/ops2_1114_sqlite.db > /dev/null 2>&1
curl -O http://www.astro.washington.edu/users/lynnej/opsim/enigma_1189_sqlite.db.gz > /dev/null 2>&1
gunzip *.gz > /dev/null 2>&1
cd ../science/Transients/
echo $PWD
ln -s ../data/*.db


