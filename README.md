# esxiDetectionLab
In progress ESXi/vSphere version of CLong's Detection Lab (https://github.com/clong/DetectionLab)

It is designed to instantiate and configure the following machines:
- Fortigate VM64 router (built from eval OVA)
- Ubuntu 16.04 jumphost
- Active Directory Domain
  - Domain Controller
  - Windows Event Collector/Forwarder
  - File Server
  - 2x Win10 Clients
  - users configured via Import-LOTR (https://github.com/jsecurity101/Import-LOTR)
- 'External' Red Team Operator (RTO)

These are all based upon vSphere templates and can be altered to fit the desired environment.

The workflow is:
`Packer => Terraform => Ansible`

Ansible playbook will be pushed to master branch soon.

### To do:
- Add Ubuntu template Packer build
- Add link to Fortigate Trial (or Packer-fy it?)
- Add diagram for better visualization
- Better documentation
