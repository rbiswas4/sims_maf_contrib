# #!/usr/bin/env bash
set -e 
conda config --add channels http://eupsforge.net/conda/dev
conda config --set always_yes true
conda install lsst-sims-maf
# > /dev/null 2>&1

source eups-setups.sh
setup sims_maf
