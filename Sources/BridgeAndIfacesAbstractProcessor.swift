import Foundation
import Iwstb

class BridgeAndIfacesAbstractProcessor: ProcessorHelper, AbstractCommandProcessor {
    private let bridgeName: String
    private let ifaces: [String]
    required init(_ params: [String]) throws {
        guard params.count > 1 else {
            throw Iwstb.Error(because: "No interface")
        }
        self.bridgeName = params[0]
        self.ifaces = Array(params[1...])
        super.init()
        try self.checkEligibility(bridge: self.bridgeName)
    }

    internal func process(command: String) throws -> Int32 {
        var count: Int = 0
        defer {
            Iwstb.log("Processed \(count) interface(s)")
        }
        for iface in self.ifaces {
            let returnCode = try Iwstb.run(
                    self.ifconfig,
                    arguments: [
                        bridgeName,
                        command,
                        iface,
                        ])
            guard returnCode == 0 else {
                return returnCode
            }
            count += 1
        }
        return 0
    }
}

