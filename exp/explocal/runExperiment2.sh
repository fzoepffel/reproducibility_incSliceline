#!/bin/bash

CMD="java -Xmx600g -Xms600g -cp ./lib/*:./SystemDS.jar org.apache.sysds.api.DMLScript "


$CMD -f exp/explocal/SlicingExp2.dml -exec singlenode -stats \
  -args data/Adult_X.csv data/Adult_o_e.csv

$CMD -f exp/explocal/SlicingExp2b.dml -exec singlenode -stats \
  -args data/Adult_X.csv data/Adult_o_e.csv
