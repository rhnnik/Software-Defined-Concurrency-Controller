#!/bin/bash
# ./runDataGen.sh <datasize. e.g., 1G, 5G, 100G, 500M, 100M>

datasize=$1
if [ "$datasize" == "1G" ]
then 
    totalbytes=1073741824 # 1GB
    totalRows=10240000 # 1G icac16    
else
    if [ "$datasize" == "5G" ]
    then
        totalbytes=5368709120 # 5GB icac16    
        totalRows=51200000 # 5G icac16
    else
        if [ "$datasize" == "10G" ]
        then
            totalbytes=10737418240 # 10GB        
            totalRows=100000000 # 10G icac16       
        else
            if [ "$datasize" == "500M" ]
            then
                totalbytes=536870912 #         
                totalRows=8000000 #        
            else  
                if [ "$datasize" == "100M" ]
                then
                    totalbytes=107374182 #         
                    totalRows=1600000 #        
                else                  
                    echo "Wrong datasize: Now use 1G, 5G, or 10G only"
                    exit
                fi
            fi
        fi
    fi
fi

#Hadoop version
version=3.0.0-alpha4

# for Grep
output=/user/hadoop/grepInput$datasize
hdfs dfs -rm -R $output
yarn jar $YARN_EXAMPLES/hadoop-mapreduce-examples-$version.jar randomtextwriter \
-D mapreduce.output.compress=false \
-D mapreduce.randomtextwriter.totalbytes=$totalbytes \
-D mapreduce.randomtextwriter.mapsperhost=3 \
$output

# for Wordcount
output=/user/hadoop/input$datasize
hdfs dfs -rm -R $output
yarn jar $YARN_EXAMPLES/hadoop-mapreduce-examples-$version.jar randomtextwriter \
-D mapreduce.output.compress=false \
-D mapreduce.randomtextwriter.totalbytes=$totalbytes \
-D mapreduce.randomtextwriter.mapsperhost=3 \
$output

# for Terasort
output=/user/hadoop/teraInput$datasize
hdfs dfs -rm -R $output
# totalRows: numer of 100 bytes rows  
yarn jar $YARN_EXAMPLES/hadoop-mapreduce-examples-$version.jar teragen $totalRows $output 


