# #!/usr/bin/env bash
set -e 
conda config --add channels http://eupsforge.net/conda/dev
conda config --set always_yes true
echo $PWD
echo 'checking disk space availability'
df -kh . 
echo 'installing sims-maf'

conda install lsst-sims-maf > /dev/null 2>&1

echo 'done installing sims-maf'
source eups-setups.sh
setup sims_maf


