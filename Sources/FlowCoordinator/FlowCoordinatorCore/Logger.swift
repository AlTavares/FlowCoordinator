//
//  Logger.swift
//  FlowCoordinator
//
//  Created by Alexandre Mantovani Tavares on 06/02/19.
//

import Foundation
import SwiftyBeaver

// swiftlint:disable:next identifier_name
public let Logger: SwiftyBeaver.Type = {
    let log = SwiftyBeaver.self
    let consoleDestination = ConsoleDestination()
    #if DEBUG
        consoleDestination.minLevel = .verbose
    #else
        consoleDestination.minLevel = .warning
    #endif
    log.addDestination(consoleDestination)
    return log
}()

public extension SwiftyBeaver {
    static func released(_ caller: Any,
                         file: String = #file,
                         line: Int = #line,
                         function: String = #function) {
        debug("\(type(of: caller.self)) released from memory", file, function, line: line)
    }

    static func ifNil<T>(_ caller: T?,
                         description: String? = nil,
                         file: String = #file,
                         line: Int = #line,
                         function: String = #function) -> T? {
        if caller == nil {
            let prepend = description ?? ""
            warning("\(prepend): \(type(of: caller.self)) is nil", file, function, line: line)
        }
        return caller
    }

    static func json(_ message: Any...,
                     file: String = #file,
                     line: Int = #line,
                     function: String = #function) {
        var message: Any = "Could not form json"
        if let data = try? JSONSerialization.data(withJSONObject: message, options: []),
            let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            message = object
        }
        debug(message, file, function, line: line)
    }
}
