import Foundation

class DestroyProcessor: BridgesOnlyAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        return try process(command: "destroy")
    }
}
