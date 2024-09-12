#!/bin/bash

# experiment 1 measures the execution time of the incremental slice line algorithm 
# for 10 iterations with increasingly large proportion of addedX/totalX (see SlicingExp1.dml)
# the values are compared with the execution time of SliceFinder for the totalX (see SlicingExp1b.dml)

CMD="java -Xmx15g -Xms15g -cp ./lib/*:./SystemDS.jar org.apache.sysds.api.DMLScript "
SIGMA="10"

$CMD -f exp/explocal/SlicingExp1.dml -exec singlenode -stats \
  -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA

$CMD -f exp/explocal/SlicingExp1b.dml -exec singlenode -stats \
  -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA

