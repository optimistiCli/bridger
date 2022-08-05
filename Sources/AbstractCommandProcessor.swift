import Foundation
import Iwstb

protocol AbstractCommandProcessor {
    init(_ params: [String]) throws
}
