# Equinix Network Edge: Silver Peak Unity EdgeConnect SD-WAN edge device

A Terraform module to create Silver Peak Unity EdgeConnect SD-WAN network edge device
on the Equinix platform.

![Terraform status](https://github.com/equinix/terraform-equinix-silverpeak-sdwan/workflows/Terraform/badge.svg)
![License](https://img.shields.io/github/license/equinix/terraform-equinix-silverpeak-sdwan)

Supported device modes:

| Management Mode | License mode | Notes |
|-----------------|--------------|-------|
| Self managed    | Bring your own license | - |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| equinix/equinix | >= 1.1.0 |

## Providers

| Name | Version |
|---------|----------|
| equinix/equinix | >= 1.1.0 |

## Assumptions

* if `account_number` is not provided, then `Active` account within given metro
will be used
* most recent, stable version of a device software for a given `software_package`
will be used
* secondary device name will be same as primary with `-secondary` suffix added
* secondary device notification list will be same as for primary
* secondary device interface count will be always same as primary interface count

## Example usage

```hcl
provider equinix {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "silverpeak-sdwan" {
  source           = "equinix/silverpeak-sdwan/equinix"
  version          = "1.0.0-beta"
  metro_code       = "SV"
  platform         = "medium"
  software_package = "EC-V"
  name             = "tf-tst-silverpeak-sdwan"
  hostname         = "silverpeak-pri"
  term_length      = 1
  notifications    = ["test@test.com"]
  acl_tempalte_id  = "2e365e34-8f38-46e1-9f57-94b075d5dc09"
  account_key      = "myAccountName"
  account_name     = "myAccountKey"
  appliance_tag    = "myApplianceTag"
  secondary = {
    enabled         = true
    metro_code      = "DC"
    hostname        = "silverpeak-sec"
    acl_tempalte_id = "81a90c41-8a22-4724-997c-bdc07f401387"
    account_key     = "myAccountName"
    account_name    = "myAccountKey"
    appliance_tag   = "myApplianceTag-sec"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|metro_code|Two-letter device location's metro code|`string`|`""`|yes|
|account_number|Billing account number for a device. If not provided, active account for a device metro code will be used|`string`|`0`|no|
|platform|Device hardware platform flavor: `small`, `medium`, `large`|`string`|`""`|yes|
|software_package|Device software package: `EC-V`|`string`|`""`|yes|
|name|Device name|`string`|`""`|yes|
|hostname|Device hostname|`string`|`""`|yes
|term_length|Term length in months: `1`, `12`, `24`, `36`|`number`|`0`|yes|
|notifications|List of email addresses that will receive notifications about device|`list(string)`|n/a|yes|
|acl_template_id|Identifier of a network ACL template that will be applied on a device|`string`|`""`|yes|
|additional_bandwidth|Amount of additional internet bandwidth for a device, in Mbps|`number`|`0`|no|
|interface_count|Device interface count: either `10` or `32`|`number`|`10`|no
|account_key|Account Key|`string`|`""`|yes
|account_name|Account name|`string`|`""`|yes
|appliance_tag|Appliance tag|`string`|`""`|no
|secondary|Map of secondary device attributes in redundant setup|`map`|N/A|no|

Secondary device map attributes:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
|enabled|Value that determines if secondary device shall be created|`bool`|`false`|no|
|hostname|Device hostname|`string`|`""`|yes
|metro_code|Two-letter secondary device location's metro code|`string`|`""`|yes|
|account_number|Billing account number for a device. If not provided, active account for a device metro code will be used|`string`|`0`|no|
|acl_template_id|Identifier of a network ACL template that will be applied on a secondary device|`string`|`""`|yes|
|additional_bandwidth|Amount of additional internet bandwidth for a secondary device, in Mbps|`number`|`0`|no|
|account_key|Account Key|`string`|`""`|yes
|account_name|Account name|`string`|`""`|yes
|appliance_tag|Appliance tag|`string`|`""`|no

## Outputs

| Name | Description |
|------|-------------|
|id|Device identifier|
|status|Device provisioning status|
|license_status|Device license status|
|account_number|Device billing account number|
|cpu_count|Number of device CPU cores|
|memory|Amount of device memory|
|software_version|Device software version|
|region|Device region|
|ibx|Device IBX center code|
|ssh_ip_address|Device SSH interface IP address|
|ssh_ip_fqdn|Device SSH interface FQDN|
|interfaces|List of network interfaces present on a device|
|secondary|Secondary device outputs (same as for primary). Present when secondary device was enabled|
