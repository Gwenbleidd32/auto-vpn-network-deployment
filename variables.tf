#Network 1
variable "net1" {
type = string
default = "griffin-school-keep"
}
#>>>
#Subnet 1
variable "net1_sub1" {
    type = string
    default = "kaer-seren-main"
}

variable "net1_sub1_iprange" {
    type = string
    default = "10.132.32.0/24"
}

variable "net1_sub1_region" {
    type = string
    default = "europe-north1"
}
#>>>
#Subnet 2
variable "net1_sub2" {
    type = string
    default = "kaer-seren-outpost"
}

variable "net1_sub2_iprange" {
    type = string
    default = "10.132.76.0/24"
}

variable "net1_sub2_region" {
    type = string
    default = "europe-west9"
}
#>>>

#Network 2
variable "net2" {
type = string
default = "griffin-school-pacific"
}
#>>>
#Subnet 1
variable "net2_sub1" {
    type = string
    default = "kaer-seren-california"
}

variable "net2_sub1_iprange" {
    type = string
    default = "192.168.32.0/24"
}

variable "net2_sub1_region" {
    type = string
    default = "us-west2"
}
#>>>
#Subnet 2
variable "net2_sub2" {
    type = string
    default = "kaer-seren-hunting-grounds"
}

variable "net2_sub2_iprange" {
    type = string
    default = "192.168.76.0/24"
}

variable "net2_sub2_region" {
    type = string
    default = "asia-northeast1"
}