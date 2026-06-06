
variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "db_instance_identifier" {
  description = "this is name for schema"
  type = string
  default = null
}

variable "password" {
  description = "passwrod for login db"
  type = string
}