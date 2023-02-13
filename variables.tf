variable "role" {
  description = "The name of the Edgescan Cloudhook Integration role"
  type        = string
  nullable    = false
  default     = "EdgescanCloudhookIntegration"
}

variable "edgescan_id" {
  description = "The ID provided by Edgescan"
  type        = number
  nullable    = false
}