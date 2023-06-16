//
//  main.swift
//  custom-events
//
//  Created by Jayson Kish on 6/10/23.
//

import ArgumentParser
import Foundation

@main
struct CustomEvents: ParsableCommand {
    
    // - MARK: Properties
    
    static var configuration = CommandConfiguration(
        abstract: "Calls jamf custom events to run concurrently.",
        version: "1.0")
    
    @Argument(
        help: "The events to call.")
    var events: [String] = []
    
    // - MARK: Program
    
    mutating func run() {
        // - TODO: Check that /usr/local/jamf/bin/jamf exists.
        if events.isEmpty {
            print("No events provided.")
        } else {
            callCustomEvents(events)
        }
    }
}

// MARK: Functions

/// Calls the events from an array of strings.
/// - Parameter events: The events to call.
func callCustomEvents(_ events: [String]) {
    for event in events {
        let process = Process()

        process.executableURL = URL(fileURLWithPath: "/usr/local/jamf/bin/jamf")
        process.arguments = ["policy", "-event", "\(event)"]

        do {
            try process.run()
        } catch {
            // Did not
        }
    }
}
