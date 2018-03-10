#!/bin/bash

while true 
do 

scp hadoop@slave1:/local/CopyMe/naik_hw4_track2_logS1.log ~

scp hadoop@slave2:/local/CopyMe/naik_hw4_track2_logS2.log ~

sleep 10
done 
