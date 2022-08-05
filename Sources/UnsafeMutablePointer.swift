import Foundation

public extension UnsafeMutablePointer {
    init?<T>(
            rawPtr unsafePtr: UnsafeMutableRawPointer?,
            ofType type: T.Type
            ) {
        guard let ptr = unsafePtr else {
            return nil
        }
        // .assumingMemoryBound ?
        self = ptr.bindMemory(
            to: Pointee.self,
            capacity: MemoryLayout<T>.stride
            )
    }
}
