import Foundation
import Iwstb

class TestProcessor: ZeroArgAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        if geteuid() == 0 {
            Iwstb.log("Effectively root")
            return 0
        } else {
            Iwstb.log("Not a root")
            return 1
        }
    }
}
