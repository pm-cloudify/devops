variable "api_key" {
  description = "Arvan API Key"
  default     = ""
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Server default region"
  default     = "ir-thr-fr1"
}

variable "distro_name" {
  type        = string
  description = " The chosen distro name for image"
  default     = "debian"
}

variable "distro_version" {
  type        = string
  description = "The chosen release for image"
  default     = "12"
}

variable "chosen_network_name" {
  type        = string
  description = "The chosen name of network"
  default     = "public201" //public202
}

variable "chosen_plan_id" {
  type        = string
  description = "The chosen ID of plan"
  default     = "g1-2-1-0"
}
