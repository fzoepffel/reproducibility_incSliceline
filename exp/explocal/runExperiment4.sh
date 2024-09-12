#!/bin/bash


# experiment 2 measures the execution time of the incremental slice line algorithm 
# for 10 iterations with increasingly large input feature matrices 
# while keeping the proportion of addedX/totalX the same over all iterations  (see SlicingExp2.dml)
# the execution is also measured for the slicefinder algorithm for the same input matrices (see SlicingExp2b.dml)

CMD="java -Xmx15g -Xms15g -cp ./lib/*:./SystemDS.jar org.apache.sysds.api.DMLScript "
SIGMA="10"



for i in {1..3}
do
  $CMD -f exp/explocal/SlicingExp4.dml -exec singlenode -stats \
    -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA 10 TRUE FALSE $i

  $CMD -f exp/explocal/SlicingExp4b.dml -exec singlenode -stats \
    -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA 10 $i
done

for i in {1..3}
do
  $CMD -f exp/explocal/SlicingExp4.dml -exec singlenode -stats \
    -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA 10 FALSE TRUE $i
done

for i in {1..3}
do
  $CMD -f exp/explocal/SlicingExp4.dml -exec singlenode -stats \
    -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA 10 FALSE FALSE $i
done
for i in {1..3}
do
  $CMD -f exp/explocal/SlicingExp4.dml -exec singlenode -stats \
    -args data/Adult_X.csv data/Adult_o_e.csv $SIGMA 10 TRUE TRUE $i
done
