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
   default=["subnet-089370fb0213bb81c","subnet-0e500fad7c16340e3"] 
}

# variable "password" {
#     default = "ExpenseApp1"
# }