#!/bin/bash


# experiment 3 compares the pruned slices on each level for incSliceLine and SliceFinder

CMD="java -Xmx15g -Xms15g -cp ./lib/*:./SystemDS.jar org.apache.sysds.api.DMLScript "
SIGMA="10"

$CMD -f exp/explocal/SlicingExp5a.dml -exec singlenode -stats \
  -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA

$CMD -f exp/explocal/SlicingExp5b.dml -exec singlenode -stats \
  -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA
