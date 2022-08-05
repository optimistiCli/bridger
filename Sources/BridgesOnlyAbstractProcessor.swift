import Foundation
import Iwstb

class BridgesOnlyAbstractProcessor: ProcessorHelper, AbstractCommandProcessor {
    private let bridgeNames: Array<String>
    required init(_ params: [String]) throws {
        guard params.count > 0 else {
            throw Iwstb.Error(because: "No bridge(s)")
        }
        self.bridgeNames = params
        super.init()
        try self.checkEligibility(bridges: self.bridgeNames)
    }

    internal func process(command: String) throws -> Int32 {
        var count: Int = 0
        defer {
            Iwstb.log("Processed \(count) bridge(s)")
        }
        for bridgeName in self.bridgeNames {
            let returnCode = try Iwstb.run(
                    self.ifconfig,
                    arguments: [
                        bridgeName,
                        command
                    ])
            guard returnCode == 0 else {
                return returnCode
            }
            count += 1
        }
        return 0
    }
}
