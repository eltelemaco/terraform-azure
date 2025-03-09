variable "service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "app_name" {
  description = "Name of the App Service"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "os_type" {
  description = "OS type for the App Service Plan (Linux or Windows)"
  type        = string
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "OS type must be either 'Linux' or 'Windows'."
  }
}

variable "sku_name" {
  description = "SKU name for the App Service Plan"
  type        = string
  default     = "B1"
}

variable "docker_image" {
  description = "Docker image to deploy (Linux only)"
  type        = string
  default     = null
}

variable "docker_image_tag" {
  description = "Docker image tag to deploy (Linux only)"
  type        = string
  default     = "latest"
}

variable "app_settings" {
  description = "Application settings for the App Service"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
} 