//
//  elevinatorTests.swift
//  elevinatorTests
//
//  Created by Mark Eschbach on 11/4/25.
//

import Foundation
import Testing
@testable import elevinator

struct elevinatorTests {
    let baseURL = "http://localhost:18999"
    
    @Test func testScenario() async throws {
        let scenarios = try! await ElevinatorClient(baseURL: baseURL).getScenarios()
        #expect(scenarios.count == 3)
        #expect(scenarios[0].Name == "single-up")
    }

    @Test func testControllers() async throws {
        
        let controllers = try! await ElevinatorClient(baseURL: baseURL).getControllers()
        #expect(controllers.count == 1)
        #expect(controllers[0].Name == "queue")
    }
    
    @Test func testRunSession() async throws {
        let client = ElevinatorClient(baseURL: baseURL)
        let scenarios = try! await client.getScenarios()
        let controllers = try! await client.getControllers()
        let session = try! await client.postSession(scenarioName: scenarios[0].Name, controllerName: controllers[0].Name)
        
        var done = false
        while !done {
            let reply = try! await client.postSessionTick(sessionID: session.sessionID)
            done = reply.completed
        }
        
        let log = try! await client.getSessionEvents(sessionID: session.sessionID)
        #expect(log.events[0].eventType == EventTypeInit)
    }
}
