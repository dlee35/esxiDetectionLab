# vsphere related params
vsphere_user = ""
vsphere_password = ""
vsphere_server = ""
vsphere_dc_name = ""
vsphere_datastore_name = ""
vsphere_compute_cluster = ""
vsphere_portgroup_name = ""
vsphere_portgroup_dmz_name = ""
vsphere_portgroup_prod_name = ""
vsphere_folder = ""
vsphere_template_win2016 = ""
vsphere_template_win10 = ""
vsphere_template_fortigate = ""
vsphere_template_rto = ""
vsphere_template_jumphost = ""

# Windows administrator password to set during vm customization
winadmin_password = ""

# FortiGate settings
FORTIGATE_name = "fortigate" # hostname
FORTIGATE_IP = "IP_ADDRESS"
FORTIGATE_cpu_num = 1
FORTIGATE_mem = 1024

# RTO settings
RTO_name = "rto" # hostname
RTO_IP = "IP_ADDRESS"
RTO_cpu_num = 2
RTO_mem = 2048

# Jumphost settings
JUMPHOST_name = "jumphost" # hostname
JUMPHOST_IP = "IP_ADDRESS"
JUMPHOST_cpu_num = 1
JUMPHOST_mem = 1024

# Primary Domain Controller settings
PDC_name = "dc" # hostname
PDC_IP = "IP_ADDRESS"
PDC_cpu_num = 4
PDC_mem = 8192

# Windows Event Forwarder settings
WEF_name = "wef" # hostname
WEF_IP = "IP_ADDRESS"
WEF_cpu_num = 4
WEF_mem = 8192

# Fileserver settings
FILESERVER_name = "flsvr01"
FILESERVER_IP = "IP_ADDRESS"
FILESERVER_cpu_num = 4
FILESERVER_mem = 8192

# Client settings
WIN101_name = "win10-1" # hostname
WIN101_IP = "IP_ADDRESS"
WIN101_cpu_num = 2
WIN101_mem = 4096

WIN102_name = "win10-2" # hostname
WIN102_IP = "IP_ADDRESS"
WIN102_cpu_num = 2
WIN102_mem = 4096

# Replica Domain Controller settings
#ReplicaDC_name = "02-replicadc"
#ReplicaDC_IP = "IP_ADDRESS"
#ReplicaDC_cpu_num = 4
#ReplicaDC_mem = 8192

# Common DMZ network params
dmz_netmask = "CIDR"
dmz_def_gw = "DMZ_GW_IP"
dmz_dns_server = "DMZ_DNS_IP"

# Common PRODUCTION network params
prod_netmask = "CIDR"
prod_def_gw = "PROD_GW_IP"
prod_dns_server = "UPSTREAM_DNS_IP"

# Common EXTERNAL network params
ext_netmask = "CIDR"
ext_def_gw = "EXT_GW_IP"
ext_dns_server = "EXT_DNS_IP"
