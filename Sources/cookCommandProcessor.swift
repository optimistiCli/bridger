import Foundation
import Iwstb

func cookCommandProcessor(for arguments: [String]) throws -> CommandProcessor {
    guard arguments.count >= 2 else {
        throw Iwstb.Error(because: "No command")
    }
    let command = arguments[1]
    let params = Array(arguments[2...])
    switch command {
    case "help":
        fallthrough
    case "-h":
        fallthrough
    case "--help":
        return try HelpProcessor(params)

    case "list":
        return try ListProcessor(params)

    case "create":
        return try CreateProcessor(params)

    case "destroy":
        return try DestroyProcessor(params)

    case "test":
        return try TestProcessor(params)

    case "up":
        return try UpProcessor(params)

    case "down":
        return try DownProcessor(params)

    case "addm":
        return try AddmProcessor(params)

    case "deletem":
        return try DeletemProcessor(params)

    default:
        throw Iwstb.Error(because: "Unknown command “\(command)”")
    }
}
