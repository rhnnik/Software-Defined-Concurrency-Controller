#!/bin/bash
if [ "$#" -lt 2 ] ; then
    echo "Usage: ./Terasort.sh <Inputfile> <logfile>"
    echo "   Ex) ./Terasort.sh /user/hadoop/teraInput1G results.txt"
    echo
    exit
fi

version=3.0.0-alpha4
input=$1
logfile=$2
output=/user/hadoop/tera`date +%s`

SECONDS=0
yarn jar $YARN_EXAMPLES/hadoop-mapreduce-examples-$version.jar terasort $input $output

echo "Total time for Terasort: $SECONDS" | tee -a $logfile
hdfs dfs -rm -r $output


