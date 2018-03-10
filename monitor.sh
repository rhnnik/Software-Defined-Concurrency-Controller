#!/bin/bash
#trap1                                                                                                  
trap 'terminating_loop; exit' SIGINT SIGQUIT                                                             
terminating_loop()                                                                                       
{                                                                                                        
echo "you hit Ctrl-C, now exiting"                                                                       
}                                                                                                        

echo "" > abc.txt                                                                                          

while true                                                                                               
do    
sleep 1
sar -uwbrqd -n DEV 1 1| awk '
BEGIN {ORS=" "} 
{
maxd = 0.0;
maxn = 0.0;
if(NR==4) {print $1, $2, hname}
if(NR==1) {hname = $3}
if(NR==4) {print "NODEINFO", 100-$7-$9, $7, $9}

if(NR==7) {print $4}

if(NR==10) {print $3}

if(NR==13) {print $3+$4, $4, $5}

if(NR==16) {print $3, $8}

if(NR==19) {print $11}



if(NR==22 && $11 > maxd) {maxd = $11}
if(NR==23 && $11 > maxd) {maxd = $11}
if(NR==24 && $11 > maxd) {maxd = $11}
if(NR==25 && $11 > maxd) {maxd = $11}



} END {print maxd}' > abc.txt

sar 1 1 | awk '{
if(NR==1) {hname=$3}
if(NR==4) {print $1, $2, hname, "TASKINFO"}
}'>tasks.txt
ps aux | grep org.apache.hadoop.mapred | awk '{if(NR>1) {sum+=$3}} END {print sum}' >> tasks.txt
ps aux | grep org.apache.hadoop.mapred | awk '{if(NR>1) {sum+=$4}} END {print sum}'>>tasks.txt

jps | awk 'BEGIN{x=0;y=0;} {if($2=="YarnChild") x+=1; if($2=="MRAppMaster")y+=1;} END {print (2*y+x),y,x}' >> tasks.txt

sudo python generate.py
echo "done"

                                                                                                  
# sar 1 1 | awk '{if(NR==4) print $1," ",$2,"\t", 100-$6-$8}' > a.txt                                      
# sar -w 1 1 | awk '{if(NR==4) print $4}' >> a.txt                                                         
# sar -b 1 1 | awk '{if(NR==4) print $3}' >> a.txt                                                         
# sar -r 1 1 | awk '{if(NR==4) print $3+$4,"\t", $4, "\t", $5}' >> a.txt                                   
# sar -q 1 1 | awk '{if(NR==4) print $3, "\t", $8}' >> a.txt                                               
# sar -d 1 1 | awk '{if(NR==4) print $11}' >> a.txt                                                        
# sar -n  DEV 1 1 | awk '{if(NR==4) print $11}' >> a.txt                                                   


done      
