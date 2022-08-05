
import Foundation

class AddmProcessor: BridgeAndIfacesAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        return try process(command: "addm")
    }
}
