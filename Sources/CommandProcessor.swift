import Foundation

protocol CommandProcessor: AbstractCommandProcessor {
    func process() throws -> Int32
}
