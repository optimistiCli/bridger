import Foundation
import Iwstb

class HelpProcessor: ZeroArgAbstractProcessor, CommandProcessor {
    func process() throws -> Int32 {
        print(Iwstb.usageLong)
        return 0
    }
}
