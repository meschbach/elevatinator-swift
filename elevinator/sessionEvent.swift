//
//  sessionEvent.swift
//  elevinator
//
//  Created by Mark Eschbach on 11/4/25.
//


let EventTypeInit = "InitStart"
let EventTypeDone = "InitDone"
let EventTypeInformFloor = "InformFloor"
let EventTypeInofrmElevator = "InformElevator"
let EventTypeTickStart = "TickStart"
let EventTypeElevatorCalled = "ElevatorCalled"
let EventTypeTickDone = "TickDone"
let EventTypeElevatorFloorRequest  = "ElevatorFloorRequest"
let EventTypeActorFinished = "ActorFinished"
let EventTypeElevatorArrived  = "ElevatorArrived"
let EventTypeElevatorAtFloor = "ElevatorAtFloor"

struct SessionEventsReplyEvent : Decodable {
    let eventType: String
    let timestamp: Int64?
    let entity: Int64?
    let elevator: Int64?
    let floor: Int64?
    let points: Int32?
}

struct SessionEventsReply : Decodable {
    let events: [SessionEventsReplyEvent]
}
