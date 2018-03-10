#!/bin/bash
if [ "$#" -lt 2 ] ; then
    echo "Usage: ./Grep.sh <Inputfile> <logfile>"
    echo "   Ex) ./Grep.sh /user/hadoop/grepInput1G results.txt"
    echo
    exit
fi

version=3.0.0-alpha4
input=$1
logfile=$2
output=/user/hadoop/grep`date +%s`

SECONDS=0
yarn jar $YARN_EXAMPLES/hadoop-mapreduce-examples-$version.jar grep $input $output \
'(dfs[a-z.]+|xml[a-z.]+|txt[a-z.]+|hdfs[a-z.]+|grep[a-z.]+|dfs[0-9.]+|xml[0-9.]+|txt[0-9.]+|hdfs[0-9.]+|grep[0-9.]+)'

echo "Total time for Grep: $SECONDS" | tee -a $logfile
hdfs dfs -rm -r $output


