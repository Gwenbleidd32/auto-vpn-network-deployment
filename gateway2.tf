#Gateway
resource "google_compute_vpn_gateway" "gateway-2" {
    name = "lunar-gateway2"
    network = google_compute_network.network_2.id
    region = var.net2_sub1_region
    depends_on = [ google_compute_subnetwork.network2_sub1]
}
#>>>

#IP Birth
resource "google_compute_address" "st2" {
  name = "orbit2"
  region = var.net2_sub1_region
}
#IP Output
output "gateway2-ip" {
  value = google_compute_address.st2.address
}
#>>>

#Fowarding Rule to Link Gatway to Generated IP
resource "google_compute_forwarding_rule" "rule4" {
  name = "rule-4"
  region = var.net2_sub1_region
  ip_protocol = "ESP"
  ip_address = google_compute_address.st2.address
  target = google_compute_vpn_gateway.gateway-2.self_link
}
#>>>

#UPD 500 traffic Rule
resource "google_compute_forwarding_rule" "rule5-500" {
  name = "rule-5"
  region = var.net2_sub1_region
  ip_protocol = "UDP"
  ip_address = google_compute_address.st2.address
  port_range = "500"
  target = google_compute_vpn_gateway.gateway-2.self_link
}
#>>>

#UDP 4500 traffic rule
resource "google_compute_forwarding_rule" "rule6-4500" {
  name = "rule-6"
  region = var.net2_sub1_region
  ip_protocol = "UDP"
  ip_address = google_compute_address.st2.address
  port_range = "4500"
  target = google_compute_vpn_gateway.gateway-2.self_link
}
#>>>

#Tunnel
resource "google_compute_vpn_tunnel" "tunnel-2" {
  name = "highliner2"
  target_vpn_gateway = google_compute_vpn_gateway.gateway-2.id
  peer_ip = google_compute_address.st1.address
  shared_secret = sensitive("faquettetuseifraise")
  ike_version = 2
  local_traffic_selector = [var.net2_sub1_iprange] 
  remote_traffic_selector = [var.net1_sub2_iprange]
  depends_on = [ 
    google_compute_forwarding_rule.rule4,
    google_compute_forwarding_rule.rule5-500,
    google_compute_forwarding_rule.rule6-4500
   ]
}
#>>>

#Next Hop to Final Destination
resource "google_compute_route" "route2" {
  name = "route2"
  network = google_compute_network.network_2.id
  dest_range = var.net1_sub2_iprange
  priority = 1000
  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel-2.id
  depends_on = [ google_compute_vpn_tunnel.tunnel-2 ]
}
#>>>

#Internal Traffic Firewall rule
resource "google_compute_firewall" "allow_internal-2" {
  name    = "allow-internal-2"
  network = var.net2

  allow {
    protocol = "all"
  }

  source_ranges = [var.net1_sub2_iprange]
  description   = "Allow all internal traffic from peer network"
}