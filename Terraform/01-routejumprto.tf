resource "vsphere_virtual_machine" "FORTIGATE" {
  name                 = var.FORTIGATE_name
  folder               = var.vsphere_folder
  firmware             = "bios" # must match template vm setting
  resource_pool_id     = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id = data.vsphere_datastore.datastore.id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.FortiGate_template.network_interface_types[0]
  }

  network_interface {
    network_id   = data.vsphere_network.dmz.id
    adapter_type = data.vsphere_virtual_machine.FortiGate_template.network_interface_types[0]
  }

  network_interface {
    network_id   = data.vsphere_network.prod.id
    adapter_type = data.vsphere_virtual_machine.FortiGate_template.network_interface_types[0]
  }

  num_cpus  = var.FORTIGATE_cpu_num
  memory    = var.FORTIGATE_mem
  guest_id  = data.vsphere_virtual_machine.FortiGate_template.guest_id
  scsi_type = data.vsphere_virtual_machine.FortiGate_template.scsi_type
  wait_for_guest_net_timeout = -1
  wait_for_guest_ip_timeout  = 5

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.FortiGate_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.FortiGate_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.FortiGate_template.disks[0].thin_provisioned
  }

  disk {
    label            = "disk1"
    unit_number      = 1
    size             = data.vsphere_virtual_machine.FortiGate_template.disks[1].size
    eagerly_scrub    = data.vsphere_virtual_machine.FortiGate_template.disks[1].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.FortiGate_template.disks[1].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.FortiGate_template.id
  }

  provisioner "local-exec" {
    command = "echo 'admin\\nadmin\\nexit' | ssh -tt -oStrictHostKeyChecking=no admin@${vsphere_virtual_machine.FORTIGATE.default_ip_address}"
  }
}

resource "vsphere_virtual_machine" "RTO" {
  name                 = var.RTO_name
  folder               = var.vsphere_folder
  firmware             = "bios" # must match template vm setting
  resource_pool_id     = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id = data.vsphere_datastore.datastore.id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.RTO_template.network_interface_types[0]
  }

  num_cpus  = var.RTO_cpu_num
  memory    = var.RTO_mem
  guest_id  = data.vsphere_virtual_machine.RTO_template.guest_id
  scsi_type = data.vsphere_virtual_machine.RTO_template.scsi_type

  disk {
    label            = "disk0"
    size             = 40
    eagerly_scrub    = data.vsphere_virtual_machine.RTO_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.RTO_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.RTO_template.id

    customize {
      linux_options {
        host_name = var.RTO_name
        domain    = "internet.external"
      }

      network_interface {
        ipv4_address = var.RTO_IP
        ipv4_netmask = var.ext_netmask
      }

      ipv4_gateway = var.ext_def_gw

      dns_server_list = [var.ext_dns_server]
    }
  }
}

resource "vsphere_virtual_machine" "JUMPHOST" {
  name                 = var.JUMPHOST_name
  folder               = var.vsphere_folder
  firmware             = "bios" # must match template vm setting
  resource_pool_id     = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id = data.vsphere_datastore.datastore.id

  network_interface {
    network_id   = data.vsphere_network.dmz.id
    adapter_type = data.vsphere_virtual_machine.Jumphost_template.network_interface_types[0]
  }

  num_cpus  = var.JUMPHOST_cpu_num
  memory    = var.JUMPHOST_mem
  guest_id  = data.vsphere_virtual_machine.Jumphost_template.guest_id
  scsi_type = data.vsphere_virtual_machine.Jumphost_template.scsi_type

  disk {
    label            = "disk0"
    size             = 40
    #size             = data.vsphere_virtual_machine.Jumphost_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.Jumphost_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.Jumphost_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.Jumphost_template.id

    customize {
      linux_options {
        host_name = var.JUMPHOST_name
        domain    = "dmz.internal"
      }

      network_interface {
        ipv4_address = var.JUMPHOST_IP
        ipv4_netmask = var.dmz_netmask
      }

      ipv4_gateway = var.dmz_def_gw

      dns_server_list = [var.dmz_dns_server]
    }
  }
}
