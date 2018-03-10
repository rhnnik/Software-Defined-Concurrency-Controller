#!/bin/bash
./Grep.sh /input/input.txt log.txt &

./Wordcount.sh /input/input.txt log.txt &

./Terasort.sh /input/workloads/input.txt log.txt &

./Grep.sh /input/input.txt log.txt &                                                                                
                                                                                                                    
./Wordcount.sh /input/input.txt log.txt &                                                                           
                                                                                                                    
./Terasort.sh /input/workloads/input.txt log.txt &  

##./Grep.sh /input/input.txt log.txt &                                                                                
                                                                                                                    
##./Wordcount.sh /input/input.txt log.txt &                                                                           
                                                                                                                    
##./Terasort.sh /input/workloads/input.txt log.txt &  

