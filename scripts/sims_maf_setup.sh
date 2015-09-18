# #!/usr/bin/env bash
set -e 
conda config --add channels http://eupsforge.net/conda/dev
conda config --set always_yes true
echo $PWD
echo 'checking disk space availability'
df -kh . 
echo 'installing sims-maf'

conda install lsst-sims-maf > /dev/null 2>&1
conda clean -y -t -p -s > /dev/null 2>&1

conda remove -y -q lsst-sims-sed-library > /dev/null 2>&1
conda remove -y -q lsst-sims-dustmaps > /dev/null 2&>1
echo 'done installing sims-maf'

source eups-setups.sh
echo 'eups setup done'
eups declare -m none -r none sims_sed_library 2014.10.06
eups declare -m none -r none sims_dustmaps 0.10.1
eups declare -m none -r none sims_dustmaps 10.1-1-g57fdb73
echo 'eups declare remove done'
setup sims_maf

