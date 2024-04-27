#Parent Network
resource google_compute_network "network_2" {
    name                    = var.net2
    description             = "Network channel for Net1 variable"
    auto_create_subnetworks = false
    routing_mode            = "REGIONAL"
    mtu                     = 1460
}

output "n2" {
    value = google_compute_network.network_2.name
}
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#Subnet1
resource google_compute_subnetwork "network2_sub1" {
    name          = var.net2_sub1
    description   = "default subnet secure"
    ip_cidr_range = var.net2_sub1_iprange
    region        = var.net2_sub1_region
    network       = google_compute_network.network_2.id
}
#>>>
output "n2_s1" {
    value = google_compute_subnetwork.network2_sub1.name
}
output "n2_s1_range" {
    value = google_compute_subnetwork.network2_sub1.ip_cidr_range
}
output "n2_s1_region" {
    value = google_compute_subnetwork.network2_sub1.region
}
#>>>
#Subnet2
resource google_compute_subnetwork "network2_sub2" {
    name          = var.net2_sub2
    description   = "default subnet2 secure"
    ip_cidr_range = var.net2_sub2_iprange
    region        = var.net2_sub2_region
    network       = google_compute_network.network_2.id
}
#>>>
output "n2_s2" {
    value = google_compute_subnetwork.network2_sub2.name
}
output "n2_s2_range" {
    value = google_compute_subnetwork.network2_sub2.ip_cidr_range
}
output "n2_s2_region" {
    value = google_compute_subnetwork.network2_sub2.region
}
#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Firewall rules
#>>>
#ICMP
resource "google_compute_firewall" "net2_icmp"{
    name = "net2-icmp"
    network = google_compute_network.network_2.id
    description = "whatforandwhy?"
    direction = "INGRESS"
    priority = 65534
    source_ranges = ["0.0.0.0/0"]
    allow {
        protocol = "icmp"
    }
}
#>>>
#RDP
resource "google_compute_firewall" "net2_rdp"{
    name = "net2-rdp"
    network = google_compute_network.network_2.id
    description = "whatforandwhy?"
    direction = "INGRESS"
    priority = 65534
    source_ranges = ["0.0.0.0/0"]
    allow {
        protocol = "tcp"
        ports = ["3389"]
    }
}
#>>>
#SSH
resource "google_compute_firewall" "net2_ssh"{
    name = "net2-ssh"
    network = google_compute_network.network_2.id
    description = "whatforandwhy?"
    direction = "INGRESS"
    priority = 65534
    source_ranges = ["0.0.0.0/0"]
    allow {
        protocol = "tcp"
        ports = ["22"]
    }
}