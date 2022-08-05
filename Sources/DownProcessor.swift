import Foundation

class DownProcessor: BridgesOnlyAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        return try process(command: "down")
    }
}
