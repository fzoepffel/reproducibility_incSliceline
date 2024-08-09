#!/bin/bash


# experiment 2 measures the execution time of the incremental slice line algorithm 
# for 10 iterations with increasingly large input feature matrices  (see SlicingExp2.dml)
# the execution is also measured for the slicefinder algorithm for the same input matrices (see SlicingExp2b.dml)

CMD="java -Xmx600g -Xms600g -cp ./lib/*:./SystemDS.jar org.apache.sysds.api.DMLScript "


$CMD -f exp/explocal/SlicingExp2.dml -exec singlenode -stats \
  -args data/Adult_X.csv data/Adult_o_e.csv 50

$CMD -f exp/explocal/SlicingExp2b.dml -exec singlenode -stats \
  -args data/Adult_X.csv data/Adult_o_e.csv 50
