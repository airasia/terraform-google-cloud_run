variable "deployer_user_groups" {
  description = "List of UserGroup emails that maybe allowed to deploy CloudRun services."
  type        = set(string)
  default     = []
}

variable "deployer_service_accounts" {
  description = "List of ServiceAccount emails that maybe allowed to deploy CloudRun services."
  type        = set(string)
  default     = []
}
