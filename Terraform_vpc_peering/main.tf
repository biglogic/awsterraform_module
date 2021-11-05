

module "peering" {
    source = "./module/vpc"
    request_cidr = "192.1.0.0/24"
    peer_cidr = "192.2.0.0/24"
    peer_region  = "us-west-1"
    tags = { "test" = "peering" }
}

module "route" {
    source = "./module/route_table/route"
    vpcid = module.peering.requester_vpc
    vpcid_peer = module.peering.accepter_vpc
    Accepter_id = module.peering.peer_id
    Requester_id = module.peering.main_peer_id
    peer_cidr = "192.2.0.0/24" 
    main_cidr = "192.1.0.0/24"
    tags = { "rt1" = "peering_rt"} 
}
