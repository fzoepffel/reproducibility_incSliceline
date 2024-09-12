#!/bin/bash


# experiment 2 measures the execution time of the incremental slice line algorithm 
# for 10 iterations with increasingly large input feature matrices 
# while keeping the proportion of addedX/totalX the same over all iterations  (see SlicingExp2.dml)
# the execution is also measured for the slicefinder algorithm for the same input matrices (see SlicingExp2b.dml)

CMD="java -Xmx15g -Xms15g -cp ./lib/*:./SystemDS.jar org.apache.sysds.api.DMLScript "
SIGMA="10"

for i in {1..10}
do
  $CMD -f exp/explocal/SlicingExp2.dml -exec singlenode -stats \
    -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA $i

  $CMD -f exp/explocal/SlicingExp2b.dml -exec singlenode -stats \
    -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA $i
done
