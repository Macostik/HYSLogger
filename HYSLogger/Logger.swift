//
//  Logger.swift
//  FishWorld
//
//  Created by Yurii Hranchenko on 07.11.2019.
//  Copyright © 2019 GYS. All rights reserved.
//

import UIKit

extension UIApplication.State {
    public func displayName() -> String {
        switch self {
        case .active: return "active"
        case .inactive: return "inactive"
        case .background: return "in background"
        default: return ""
        }
    }
}

public struct Logger {
    static let logglyDestination = SlimLogglyDestination()
    static func configure() {
        Slim.addLogDestination(logglyDestination)
    }
    public enum LogType: String {
        case `default` = ""
        case warning = "⚠️ Warning: "
        case info = "ℹ️ Info: "
        case error = "🔥 Error: "
        case debug = "🐞 Debug: "
        case verbose = "👍 Verbose: "
    }
    static func debugLog(_ string: @autoclosure () -> String,
                         type: LogType = .default,
                         filename: String = #file,
                         line: Int = #line,
                         isDebug: Bool = true) {
        if isDebug {
            Slim.debug("\(type.rawValue)\(string())\n",
                filename: filename,
                line: line)
        }
    }
    static func log<T>(_ message: @autoclosure () -> T,
                       type: LogType = .default,
                       filename: String = #file,
                       line: Int = #line,
                       isDebug: Bool = true) {
        if isDebug {
            Slim.debug("\(type.rawValue)\(message())\n",
                filename: filename,
                line: line)
        } else {
            Slim.info(message(), filename: filename, line: line)
        }
    }
    public static func error<T>(_ message: @autoclosure () -> T,
                         filename: String = #file,
                         line: Int = #line) {
        log(message(), type: .error, filename: filename, line: line)
    }
    public static func debug<T>(_ message: @autoclosure () -> T,
                         filename: String = #file,
                         line: Int = #line) {
        log(message(), type: .debug, filename: filename, line: line)
    }
    public static func warning<T>(_ message: @autoclosure () -> T,
                            filename: String = #file,
                            line: Int = #line) {
        log(message(), type: .warning, filename: filename, line: line)
    }
    public static func info<T>(_ message: @autoclosure () -> T,
                        filename: String = #file,
                        line: Int = #line) {
        log(message(), type: .info, filename: filename, line: line)
    }
    public static func verbose<T>(_ message: @autoclosure () -> T,
                           filename: String = #file,
                           line: Int = #line) {
        log(message(), type: .verbose, filename: filename, line: line)
    }
}
