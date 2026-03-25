variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "zone_id" {
    default = "Z021448929NMXW4P65UQE"
}

variable "domain_name" {
    default = "daws82s.online"
}

variable "database_subnet_ids"{
   default=["10.0.21.0/24","10.0.22.0/24"] 
}

# variable "password" {
#     default = "ExpenseApp1"
# }