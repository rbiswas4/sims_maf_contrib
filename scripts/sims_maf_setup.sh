# #!/usr/bin/env bash
set -e 
conda config --add channels http://eupsforge.net/conda/dev
conda install lsst-sims-maf

source eups-setups.sh
setup sims_maf
