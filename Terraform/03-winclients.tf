resource "vsphere_virtual_machine" "WIN10-1" {
  name                 = var.WIN101_name
  folder               = var.vsphere_folder
  firmware             = "bios" # must match template vm setting
  resource_pool_id     = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id = data.vsphere_datastore.datastore.id

  network_interface {
    network_id   = data.vsphere_network.prod.id
    adapter_type = data.vsphere_virtual_machine.WIN10_template.network_interface_types[0]
  }

  num_cpus  = var.WIN101_cpu_num
  memory    = var.WIN101_mem
  guest_id  = data.vsphere_virtual_machine.WIN10_template.guest_id
  scsi_type = data.vsphere_virtual_machine.WIN10_template.scsi_type

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.WIN10_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.WIN10_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.WIN10_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.WIN10_template.id

    customize {
      windows_options {
        computer_name    = var.WIN101_name
        admin_password   = var.winadmin_password
        auto_logon       = true
        auto_logon_count = 1

        # Run these commands after autologon. Configure WinRM access and disable windows firewall.
        run_once_command_list = [
          "winrm quickconfig -force",
          "winrm set winrm/config @{MaxEnvelopeSizekb=\"100000\"}",
          "winrm set winrm/config/Service @{AllowUnencrypted=\"true\"}",
          "winrm set winrm/config/Service/Auth @{Basic=\"true\"}",
          "netsh advfirewall set allprofiles state off",
        ]
      }

      network_interface {
        ipv4_address    = var.WIN101_IP
        ipv4_netmask    = var.prod_netmask
        dns_server_list = [var.PDC_IP]
      }

      ipv4_gateway = var.prod_def_gw
    }
  }
}

resource "vsphere_virtual_machine" "WIN10-2" {
  name                 = var.WIN102_name
  folder               = var.vsphere_folder
  firmware             = "bios" # must match template vm setting
  resource_pool_id     = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id = data.vsphere_datastore.datastore.id

  network_interface {
    network_id   = data.vsphere_network.prod.id
    adapter_type = data.vsphere_virtual_machine.WIN10_template.network_interface_types[0]
  }

  num_cpus  = var.WIN102_cpu_num
  memory    = var.WIN102_mem
  guest_id  = data.vsphere_virtual_machine.WIN10_template.guest_id
  scsi_type = data.vsphere_virtual_machine.WIN10_template.scsi_type

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.WIN10_template.disks[0].size
    eagerly_scrub    = data.vsphere_virtual_machine.WIN10_template.disks[0].eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.WIN10_template.disks[0].thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.WIN10_template.id

    customize {
      windows_options {
        computer_name    = var.WIN102_name
        admin_password   = var.winadmin_password
        auto_logon       = true
        auto_logon_count = 1

        # Run these commands after autologon. Configure WinRM access and disable windows firewall.
        run_once_command_list = [
          "winrm quickconfig -force",
          "winrm set winrm/config @{MaxEnvelopeSizekb=\"100000\"}",
          "winrm set winrm/config/Service @{AllowUnencrypted=\"true\"}",
          "winrm set winrm/config/Service/Auth @{Basic=\"true\"}",
          "netsh advfirewall set allprofiles state off",
        ]
      }

      network_interface {
        ipv4_address    = var.WIN102_IP
        ipv4_netmask    = var.prod_netmask
        dns_server_list = [var.PDC_IP]
      }

      ipv4_gateway = var.prod_def_gw
    }
  }
}

