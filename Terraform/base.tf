# Base config
# Vcenter connection parameters
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

# Fetch datacenter data
data "vsphere_datacenter" "dc" {
  name = var.vsphere_dc_name
}

# Fetch datastore data
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Fetch compute cluster data
data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Fetch port group data
data "vsphere_network" "network" {
  name          = var.vsphere_portgroup_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "dmz" {
  name          = var.vsphere_portgroup_dmz_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "prod" {
  name          = var.vsphere_portgroup_prod_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Fetch template vm data
data "vsphere_virtual_machine" "Win2016GUI_template" {
  name          = var.vsphere_template_win2016
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "WIN10_template" {
  name          = var.vsphere_template_win10
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "FortiGate_template" {
  name          = var.vsphere_template_fortigate
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "RTO_template" {
  name          = var.vsphere_template_rto
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "Jumphost_template" {
  name          = var.vsphere_template_jumphost
  datacenter_id = data.vsphere_datacenter.dc.id
}
