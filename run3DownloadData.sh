#!/bin/bash

# This script downloads all real datasets shown in Table 1 of the paper
# The remaining datasets are then created via replicating some of these datasets

mkdir -p data;
chmod 755 data;

# Adult 
curl https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data -o data/Adult.csv;
sed -i '' '$d' data/Adult.csv; # fix empty line at end of file 
# note: workaround for macOS issue: sed -i '' 's/-/ /g' data/KDD98.csv; 
# on linux, use: sed -i '$d' data/Adult.csv;

