//
//  secnario.swift
//  
//
//  Created by Mark Eschbach on 11/4/25.
//

struct Scenario: Decodable {
    let Name: String
    let Description: String
}

struct GetScenariosReply: Decodable {
    let available: [Scenario]
}
