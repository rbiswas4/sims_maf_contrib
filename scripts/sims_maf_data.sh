# #!/usr/bin/env bash
set -e 
echo 'Make data directory'
echo $PWD
mkdir -p ./data
wget -nc -q http://www.astro.washington.edu/users/lynnej/opsim/ops2_1114_sqlite.db
#http://ops2.tuc.noao.edu/runs/ops2_1114/data/ops2_1114_sqlite.db
wget -q -O - http://www.astro.washington.edu/users/lynnej/opsim/enigma_1189_sqlite.db.gz | gunzip -c > enigma_1189_sqlite.db
# curl -O http://www.astro.washington.edu/users/lynnej/opsim/ops2_1114_sqlite.db > /dev/null 2>&1
#curl -O http://www.astro.washington.edu/users/lynnej/opsim/enigma_1189_sqlite.db.gz > /dev/null 2>&1
echo 'Downloads of opsim runs done'
echo `ls `
# gunzip *.gz
echo 'unzip done'
for dbfile in `ls *.db`; do 
    file=`basename $dbfile`; 
    echo $file
    mv $dbfile ./data; 
    ln -s ./data/$dbfile ./science/Transients/$file;
done
echo 'Check cleanup'
echo `ls `
echo 'Check that ./science/Transients/ hs the required db'
echo `ls ./science/Transients/*.db`
echo 'Check available disk space'
df -kh .
