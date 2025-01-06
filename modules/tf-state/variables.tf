variable "environment" {
  description = "Environment name"
  type        = string  
}

variable "force_destroy" {
  description = "To delete content on bucket delete or not" 
  type        = bool
  default = false 
}

variable "block_public_acls" {
  description = "Whether to block public ACLs for the S3 bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs for the S3 bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether to block public bucket policies."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether to restrict access to public buckets."
  type        = bool
  default     = true
}

variable "table_name" {
  description = "Lock table name"
  type = string
  default = "tf-state-lock"   
}