#!/usr/bin/env bash
# Used to make a conda environment with deepchem

# Change commented out line For gpu tensorflow
#export tensorflow=tensorflow-gpu
export tensorflow=tensorflow

if [ -z "$gpu" ]
then
    export tensorflow=tensorflow
    echo "Using Tensorflow (CPU MODE) by default."
elif [ "$gpu" == 1 ]
then
    export tensorflow=tensorflow-gpu
    echo "Using Tensorflow (GPU MODE)."
else
    echo "Using Tensorflow (CPU MODE) by default."
fi

if [ -z "$python_version" ]
then
    echo "Using python 3.5 by default"
    export python_version=3.5
else
    echo "Using python "$python_version". But recommended to use python 3.5."
fi

if [ -z "$1" ];
then
    echo "Installing DeepChem in current env"
else
    export envname=$1
    conda create -y --name $envname python=$python_version
    source activate $envname
fi

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
   source activate root
   conda install -y -q conda=4.3.34
   source activate $envname
   conda install -y -q python=3.5.3
fi

conda config --add channels conda-forge
conda config --add channels rdkit

conda install -y -q joblib=0.11 \
    rdkit=2017.09.3 \
    scikit-learn \
    matplotlib \
    xgboost \
    pandas \
    molvs \
    $tensorflow=1.9.0 \
    jupyter
