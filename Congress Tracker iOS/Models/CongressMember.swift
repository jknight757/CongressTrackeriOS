//
//  CongressMember.swift
//  Congress Tracker iOS
//
//  Created by jeffrey knight on 3/24/20.
//  Copyright © 2020 fullsailStudent. All rights reserved.
//

import Foundation
struct Results: Codable{
    var results: [Member]
    
}
struct SingleResults: Codable{
    var results: [SingleMemberDetail]
}
struct Member: Codable {
    var members:[memberDetail]
    
}
struct memberDetail: Codable{
    var first_name: String
    var last_name: String
    var party: String?
    var state: String?
    var chamber: String?
    var api_uri: String
    var url: String?
    
}
struct SingleMemberDetail: Codable{
    var id: String
    var first_name: String
    var last_name: String
    var current_party: String?
    var roles: [memberTerm]?
    
}

struct memberTerm: Codable{
    var party: String?
    var chamber: String?
    var state: String?
    var seniority: String?
    var next_election: String?
    var total_votes: Int?
    var missed_votes: Int?
    var missed_votes_pct: Double?
    var votes_with_party_pct: Double?
    var votes_against_party_pct: Double?
}
