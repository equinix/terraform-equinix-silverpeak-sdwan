# Equinix Network Edge example: Silver Peak Unity EdgeConnect SD-WAN edge device

This example shows how to create redundant Silver Peak Unity EdgeConnect SD-WAN
edge devices on Platform Equinix using Equinix Silver Peak SD-WAN Terraform module
and Equinix Terraform provider.

In addition to pair of Silver Peak SD-WAN devices, following resources are being
created in this example:

* two ACL templates, one for each of the device

The devices are created in self managed, bring your own license modes.
Remaining parameters include:

* medium hardware platform (4CPU cores, 8GB of memory)
* EC-V software package
* account names and keys
* appliance tags
* 100 Mbps of additional internet bandwidth on each device
