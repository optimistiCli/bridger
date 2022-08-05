import Foundation

public extension String {
    init?(cString unsafePtr: UnsafePointer<CChar>?) {
        guard let ptr = unsafePtr else {
            return nil
        }
        self = String(cString: ptr)
    }
}
