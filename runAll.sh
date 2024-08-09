#!/bin/bash

# clean original results
rm -R results/*;
rm -R plots/*;

# setup, run experiments, plots
./run1SetupDependencies.sh;
./run2SetupSystemDS.sh;
./run3DownloadData.sh;
./run4PrepareLocalData.sh; # on scale-up node
./run5LocalExperiments.sh; # on scale-up node 
./run8PlotResults.sh;
