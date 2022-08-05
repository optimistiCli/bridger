
import Foundation

class DeletemProcessor: BridgeAndIfacesAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        return try process(command: "deletem")
    }
}
