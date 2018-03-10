A. Start Monitors:
1. sudo ./monitor.sh   - slave1
2. sudo ./monitor.sh   - slave2
3. ./import.sh		- master

B. Update nodeIDs in local controllers:
vi localcont.py
## go to line 53 and line 67
## command starts from os.system("...
##update nodeID with respective ID of cluster
##if ID is not known: use 
	$yarn node -list

C. Start Controlers:
4. python localcont.py
5. python localcont.py
6. python globalcont.py

D. Start Workload:
cd /workloads
./runwl.sh
