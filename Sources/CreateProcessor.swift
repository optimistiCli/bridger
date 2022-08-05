import Foundation
import Iwstb

class CreateProcessor: ZeroArgAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        let bridgeName = try cookAvailableBridgeName()
        defer {
            print(bridgeName)
        }
        return try Iwstb.run(
                self.ifconfig,
                arguments: [
                    bridgeName,
                    "create"
                ])
    }

    private func cookAvailableBridgeName() throws -> String {
        for i in 0...255 {
            let candidate = "bridge\(i)"
            guard try !self.existingBridges.contains(candidate) else {
                continue
            }
            return candidate
        }
        throw Iwstb.Error(because: "No bridge names available")
    }
}
