//
//  controller.swift
//  elevinator
//
//  Created by Mark Eschbach on 11/4/25.
//

struct Controller : Decodable {
    let Name: String
}

struct GetControllersReply: Decodable {
    let available: [Controller]
}

