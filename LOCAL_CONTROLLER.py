import time 
import os
import subprocess
 

#with open("naik_hw4_track2_logS1.log","r") as a:
#	conta = a.read()
#	lista = conta.split(" ")
		
avg = 10    	#number of cycles considered
#ncpu = float(lista[-23])
#print("==========================>", ncpu)
						#mr cpu
#mrcpu = lista[-7]
#print("==========================>", mrcpu)
n=0
vcore = 10 
memory = 10240
count = 0
#os.system("sudo touch ~/local/CopyMe/flags1.txt")

while True:
	
#	flag=open("~/local/CopyMe/flags1.txt","w")
	with open("naik_hw4_track2_logS1.log","r") as a:                                                                    
        	conta = a.read()                                                                                            
        	lista = conta.split(" ")
	ncpu = float(lista[-23])
        mrcpu = lista[-7]
	#print ("====>", ncpu  )                                         
                      
                                                                         
        #print ("====>" ,mrcpu)
	ncpuSum = 0
	mrcpuSum=0
	ncpuAvg=0
	localflag = False
	maxCT = 0

	for i in range(0,avg):
		ncpu = float(lista[-23-i*26])
		#mrcpu = float(lista[-7-i*26])
		ncpuSum = ncpu+ncpuSum
		#mrcpuSum = mrcpu+mrcpuSum
		i=i+1
		#print("ncpu ====> ",ncpu)
			
	ncpuAvg = ncpuSum/(i+1)
	ncpudelta = abs(float(lista[-23])- ncpuAvg)
	print("Last 10 average",ncpuAvg)
	print("DELTA ncpu", ncpudelta)
	if ncpuAvg <= 70.00 and ncpuAvg >= 5.0: # and ncpudelta >10.0:   #target max cpu utilization
		os.system("yarn rmadmin -updateNodeResource ms0906.utah.cloudlab.us:39116 "+ str(memory+1024)+ " "+str(vcore+1))
		#os.system("yarn rmadmin -updateNodeResource ms0906.utah.cloudlab.us:37167 32768 16")
		print("============= CPU underutilized | numCt added ============== MEM= "+ str(memory+1024) +  "vcores= "+str(vcore+1) )
		count+=1
		memory+=1024
		print("Memory ====> ", memory)
		vcore+=1
		print("vcore ==== ", vcore)
		n+=1
		maxCT = vcore
		localflag = True
		time.sleep(10)
	
	elif ncpuAvg >= 90.0:
		os.system("yarn rmadmin -updateNodeResource ms0906.utah.cloudlab.us:37167 "+ str(memory-1024)+ " "+
str(vcore-1))
		print("=========decrement========= MEM= "+str(memory-1024)+ "vcores= "+str(vcore-1))
		count-=1
		memory-=1024
		print(memory)

		vcore-=1
		print(vcore)
		n+=1
		maxCT = vcore
		localflag = False
		time.sleep(10) 
		
	else:	 
		print("========================All is Well!============================")
		n+=1
		time.sleep(10)

	#flag.write(str(maxct)+" ")
	#flag.write(str(localflag))
	#flag.close()
	#time.sleep(1)
