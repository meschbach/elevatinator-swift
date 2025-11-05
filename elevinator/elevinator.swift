//
//  elevinator.swift
//  elevinator
//
//  Created by Mark Eschbach on 11/4/25.
//

import Foundation


struct PostSessionTickReply : Decodable {
    let completed: Bool
}

struct ElevinatorClient {
    let baseURL : String
    
    func getScenarios() async throws -> [Scenario] {
        let reply = try! await self.getResource(path: "/scenarios", targetType: GetScenariosReply.self)
        return reply.available
    }

    func getControllers() async throws -> [Controller] {
        let reply = try! await self.getResource(path: "/controllers", targetType: GetControllersReply.self)
        return reply.available
    }
    
    func getSessionEvents(sessionID: String) async throws -> SessionEventsReply {
        let reply = try! await self.getResource(path: "/session/"+sessionID+"/events", targetType: SessionEventsReply.self)
        return reply
    }
    
    func postSession(scenarioName:String, controllerName:String) async throws -> PostSessionReply {
        let url = URL(string: self.baseURL + "/session")
        var req = URLRequest(url: url!)
        req.httpMethod = "POST"
        req.httpBody = try! JSONEncoder().encode(PostSessionRequest(scenario: scenarioName, controller: controllerName))
        let (data,response) = try await URLSession.shared.data(for: req)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200 {
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)
        }
        let reply = try! JSONDecoder().decode(PostSessionReply.self, from: data)
        return reply
    }

    func postSessionTick(sessionID: String) async throws -> PostSessionTickReply {
        let url = URL(string: self.baseURL + "/session/" + sessionID + "/tick")
        var req = URLRequest(url: url!)
        req.httpMethod = "POST"
        let (data,response) = try await URLSession.shared.data(for: req)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200 {
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)
        }
        let reply = try! JSONDecoder().decode(PostSessionTickReply.self, from: data)
        return reply
    }
    
    private func getResource<T>(path:String, targetType: T.Type) async throws -> T where T : Decodable {
        let url = URL(string: self.baseURL + path)
        let (data,response) = try await URLSession.shared.data(from: url!)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode != 200 {
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)
        }
        let reply = try! JSONDecoder().decode(targetType, from: data)
        return reply
    }
}
