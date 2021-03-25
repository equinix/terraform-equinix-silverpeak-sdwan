provider "equinix" {
  client_id     = var.equinix_client_id
  client_secret = var.equinix_client_secret
}

module "silverpeak-sdwan" {
  source               = "equinix/silverpeak-sdwan/equinix"
  version              = "1.0.0-beta"
  name                 = "tf-silverpeak-sdwan"
  hostname             = "silverpeak-pri"
  metro_code           = var.metro_code_primary
  platform             = "medium"
  software_package     = "EC-V"
  term_length          = 1
  notifications        = ["test@test.com"]
  additional_bandwidth = 100
  acl_template_id      = equinix_network_acl_template.silverpeak-pri.id
  account_key          = "myAccountName"
  account_name         = "myAccountKey"
  appliance_tag        = "myApplianceTag"
  secondary = {
    enabled              = true
    metro_code           = var.metro_code_secondary
    hostname             = "silverpeak-sec"
    additional_bandwidth = 100
    acl_template_id      = equinix_network_acl_template.silverpeak-sec.id
    account_key          = "myAccountName"
    account_name         = "myAccountKey"
    appliance_tag        = "myApplianceTag-sec"
  }
}

resource "equinix_network_acl_template" "silverpeak-pri" {
  name        = "tf-silverpeak-pri"
  description = "Primary Silver Peak SD-WAN ACL template"
  metro_code  = var.metro_code_primary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}

resource "equinix_network_acl_template" "silverpeak-sec" {
  name        = "tf-silverpeak-sec"
  description = "Secondary Silver Peak SD-WAN ACL template"
  metro_code  = var.metro_code_secondary
  inbound_rule {
    subnets  = ["193.39.0.0/16", "12.16.103.0/24"]
    protocol = "TCP"
    src_port = "any"
    dst_port = "22"
  }
}
