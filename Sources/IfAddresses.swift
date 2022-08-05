import Foundation
import Iwstb

public class IfAddresses: Sequence, IteratorProtocol {
    private let startPtr: UnsafeMutablePointer<ifaddrs>
    private var nextPtr: UnsafeMutablePointer<ifaddrs>?

    init() throws {
        var optionalPtr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&optionalPtr) == 0,
                let startPtr = optionalPtr
                else {
            let errMsg = "Can't get ifaces list"
            if let errnoDescr = ErrorH.getErrnoDescr() {
                throw Iwstb.Error(because: ("\(errMsg) due to \(errnoDescr)"))
            } else {
                throw Iwstb.Error(because: (errMsg))
            }
        }
        self.startPtr = startPtr
        self.nextPtr = startPtr
    }

    public func next() -> UnsafeMutablePointer<ifaddrs>? {
        guard let nextPtr = self.nextPtr else {
            return nil
        }
        self.nextPtr = nextPtr.pointee.ifa_next
        return nextPtr
    }

    deinit {
        freeifaddrs(self.startPtr)
    }
}
