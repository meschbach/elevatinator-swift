# Elevinator Swift Library

This is a client library of https://github.com/meschbach/elevatinator for the REST API.

## Example Usage
The following will setup a game session with the first controller and scenario returned, then retrieve all log entries.

```swift
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
print(log)
```

