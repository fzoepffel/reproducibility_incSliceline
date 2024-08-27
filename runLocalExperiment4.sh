#!/bin/bash

# This script runs all local experiments on the specified scale-up machine.

# All scripts are ran with 600GB JVM heap size but would also work with smaller 
# JVMs (selectively tested with 110GB on one of the scale-out nodes).

export CMD="java -Xmx600g -Xms600g -cp ./lib/*:./SystemDS.jar org.apache.sysds.api.DMLScript "

./exp/explocal/runExperiment4.sh
