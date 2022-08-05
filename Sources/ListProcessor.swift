import Foundation

class ListProcessor: ZeroArgAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        for bridgeName in Array(try self.existingBridges).sorted() {
            print(bridgeName + (self.scBridges.contains(bridgeName)
                    ? ": System Configuration"
                    : ": BSD"
                    ))
        }
        return 0
    }
}
