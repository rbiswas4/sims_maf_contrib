# #!/usr/bin/env bash
set -e 
echo 'Make data directory'
echo $PWD
mkdir -p ./data
curl -O http://www.astro.washington.edu/users/lynnej/opsim/ops2_1114_sqlite.db > /dev/null 2>&1
curl -O http://www.astro.washington.edu/users/lynnej/opsim/enigma_1189_sqlite.db.gz > /dev/null 2>&1
gunzip *.gz
for dbfile in `ls *.db`; do echo $dbfile; do mv $dbfile ./data; do ln -s ./science/Transients/$dbfile ./data/$dbfile; done
rm *.gz


