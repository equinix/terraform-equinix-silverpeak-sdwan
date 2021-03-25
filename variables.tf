variable "metro_code" {
  description = "Device location metro code"
  type        = string
  validation {
    condition     = can(regex("^[A-Z]{2}$", var.metro_code))
    error_message = "Valid metro code consits of two capital leters, i.e. SV, DC."
  }
}

variable "account_number" {
  description = "Billing account number for a device"
  type        = string
  default     = 0
}

variable "platform" {
  description = "Device platform flavor that determines number of CPU cores and memory"
  type        = string
  validation {
    condition     = can(regex("^(small|medium|large)$", var.platform))
    error_message = "One of following platform flavors are supported: small, medium, large."
  }
}

variable "software_package" {
  description = "Device software package"
  type        = string
  validation {
    condition     = can(regex("^(EC-V)$", var.software_package))
    error_message = "One of following software packages are supported: EC-V."
  }
}

variable "name" {
  description = "Device name"
  type        = string
  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 50
    error_message = "Device name should consist of 2 to 50 characters."
  }
}

variable "hostname" {
  description = "Device hostname"
  type        = string
  validation {
    condition     = length(var.hostname) >= 5 && length(var.hostname) <= 50
    error_message = "Device hostname should consist of 2 to 50 characters."
  }
}

variable "term_length" {
  description = "Term length in months"
  type        = number
  validation {
    condition     = can(regex("^(1|12|24|36)$", var.term_length))
    error_message = "One of following term lengths are available: 1, 12, 24, 36 months."
  }
}

variable "notifications" {
  description = "List of email addresses that will receive device status notifications"
  type        = list(string)
  validation {
    condition     = length(var.notifications) > 0
    error_message = "Notification list cannot be empty."
  }
}

variable "acl_template_id" {
  description = "Identifier of an ACL template that will be applied on a device"
  type        = string
  validation {
    condition     = length(var.acl_template_id) > 0
    error_message = "ACL template identifier has to be an non empty string."
  }
}

variable "additional_bandwidth" {
  description = "Additional internet bandwidth for a device"
  type        = number
  default     = 0
  validation {
    condition     = var.additional_bandwidth == 0 || (var.additional_bandwidth >= 25 && var.additional_bandwidth <= 2001)
    error_message = "Additional internet bandwidth should be between 25 and 2001 Mbps."
  }
}

variable "interface_count" {
  description = "Number of network interfaces on a device"
  type        = number
  default     = 0
  validation {
    condition     = var.interface_count == 0 || var.interface_count == 10 || var.interface_count == 32
    error_message = "Device interface count has to be either 10 or 32."
  }
}

variable "account_key" {
  description = "Account Key"
  type        = string
  validation {
    condition     = length(var.account_key) >= 5 && length(var.account_key) <= 50
    error_message = "Account Key has to be from 5 to 50 characters long."
  }
}

variable "account_name" {
  description = "Account name"
  type        = string
  validation {
    condition     = length(var.account_name) >= 5 && length(var.account_name) <= 50
    error_message = "Account name has to be from 5 to 50 characters long."
  }
}

variable "appliance_tag" {
  description = "Appliance tag"
  type        = string
  default     = ""
  validation {
    condition     = length(var.appliance_tag) == 0 || (length(var.appliance_tag) >= 5 && length(var.appliance_tag) <= 50)
    error_message = "Device root password has to be from 5 to 50 characters long."
  }
}

variable "secondary" {
  description = "Secondary device attributes"
  type        = map(any)
  default     = { enabled = false }
  validation {
    condition     = can(var.secondary.enabled)
    error_message = "Key 'enabled' has to be defined for secondary device."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || can(regex("^[A-Z]{2}$", var.secondary.metro_code))
    error_message = "Key 'metro_code' has to be defined for secondary device. Valid metro code consits of two capital leters, i.e. SV, DC."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.hostname) >= 5 && length(var.secondary.hostname) <= 50, false)
    error_message = "Key 'hostname' has to be defined for secondary device. Valid hostname has to be from 5 to 50 characters long."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.acl_template_id) > 0, false)
    error_message = "Key 'acl_template_id' has to be defined for secondary device. Valid ACL template identifier has to be an non empty string."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(var.secondary.additional_bandwidth >= 25 && var.secondary.additional_bandwidth <= 2001, true)
    error_message = "Key 'additional_bandwidth' has to be between 25 and 2001 Mbps."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.account_key) >= 5 && length(var.secondary.account_key) <= 50, false)
    error_message = "Key 'account_key' has to be defined for secondary device. Valid account key has to be 5 to 50 characters long."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.account_name) >= 5 && length(var.secondary.account_name) <= 50, false)
    error_message = "Key 'account_name' has to be defined for secondary device. Valid account name has to be 5 to 50 characters long."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.appliance_tag) >= 5 && length(var.secondary.appliance_tag) <= 50, true)
    error_message = "Valid appliance tag has to be from 5 to 50 characters long."
  }
}
