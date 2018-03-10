#!/bin/bash
if [ "$#" -lt 2 ] ; then
    echo "Usage: ./Wordcount.sh <Inputfile> <logfile>"
    echo "   Ex) ./Wordcount.sh /user/hadoop/wordInput1G results.txt"
    echo
    exit
fi

version=3.0.0-alpha4
input=$1
logfile=$2
output=/user/hadoop/word`date +%s`

SECONDS=0
yarn jar $YARN_EXAMPLES/hadoop-mapreduce-examples-$version.jar wordcount $input $output

echo "Total time for Wordcount: $SECONDS" | tee -a $logfile
hdfs dfs -rm -R $output
