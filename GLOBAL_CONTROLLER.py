#! usr/bin/python
import xml.etree.ElementTree as ET
import os 
import subprocess
import time

tree = ET.parse("/home/hadoop/hadoop/etc/hadoop/capacity-scheduler.xml")
amrp =float((tree.findall('property/value')[1]).text) ##maxnumjobs= ((amrp*maxnumCTs)/2)
n = 0
(tree.findall('property/value')[1]).text = '0.2'
#os.system("./import.sh")

while True:
#loops here 

	with open("/home/hadoop/naik_hw4_track2_logS1.log","r") as s1:
		conts1 = s1.read()
		lists1 = conts1.split(" ")
		
		print(lists1[-23])
	with open("/home/hadoop/naik_hw4_track2_logS2.log","r") as s2:
        	conts2 = s2.read()
        	lists2 = conts2.split(" ")
		
		print(lists2[-23])
	totalcpu = float(lists1[-23]) + float(lists2[-23])

	if totalcpu >=5.0 and totalcpu <=140.0 and amrp<0.7:
		(tree.findall('property/value')[1]).text =str(amrp + 0.1)
		#os.system('yarn rmadmin -refreshQueues')
		amrp = amrp + 0.1
		print("AMRP increased, now", amrp)
		time.sleep(10)

	elif totalcpu>=180.0:
		(tree.findall('property/value')[1]).text =str(amrp - 0.1)
		#os.system('yarn rmadmin -refreshQueues')
		amrp = amrp - 0.1
		print("AMRP decreased, now", amrp )
		time.sleep(10)

	else:
		print("========== all is well ==========")
		
		time.sleep(10)
	########STATIC CONFIG#############
	#(tree.findall('property/value')[1]).text = '0.2'



	tree.write("/home/hadoop/hadoop/etc/hadoop/capacity-scheduler.xml")
	os.system('yarn rmadmin -refreshQueues')

