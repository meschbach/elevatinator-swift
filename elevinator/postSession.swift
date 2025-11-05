//
//  postSession.swift
//  elevinator
//
//  Created by Mark Eschbach on 11/4/25.
//


struct PostSessionRequest :Encodable {
    let scenario: String
    let controller: String
}

struct PostSessionReply : Decodable {
    let sessionID: String
}
