import Foundation

class UpProcessor: BridgesOnlyAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        return try process(command: "up")
    }
}
