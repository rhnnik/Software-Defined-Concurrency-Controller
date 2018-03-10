import geni.portal as portal
import geni.rspec.pg as pg
import geni.rspec.igext
pc = portal.Context()
rspec = pg.Request()
ntfs = []
num = 5
#for idx in range (0,num+1):
for idx in range(3):
	if idx == 0:
		vm = pg.RawPC("master")
	else:
		vm = pg.RawPC("slave%d" % (idx))
	intf = vm.addInterface("if%d" %(idx))
	intfs.append(intf)
	vm.disk_image = "urn:publicid:IDN+utah.cloudlab.us+image+sthp-PG0:hd3a4"
	if idx==0:
		vm.routable_control_ip = "true"

	vm.addService(pg.Execute(shell="bash", command="sudo /local/CopyMe/install_node.sh"))
	rspec.addResource(vm)
link = pg.LAN("lan")
for intf in intfs:
	link.addInterface(intf)
	#special parameters to resolve an error: "Not enough available bandwidth for a link"
	link.best_effort = True
	link.vlan_tagging = True

rspec.addResource(link)
pc.printRequestRSpec(rspec)