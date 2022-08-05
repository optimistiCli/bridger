import Foundation
import SystemConfiguration
import Iwstb

class ProcessorHelper {
    private(set) lazy var ifconfig = URL(fileURLWithPath: "/sbin/ifconfig")

    private(set) lazy var scBridges = getSCBridgeNames()

    private var _existingBridges: Set<String>? = nil
    var existingBridges: Set<String> {
        get throws {
            if _existingBridges == nil {
                _existingBridges = try getBridgeNames()
            }
            return _existingBridges!
        }
    }

    func checkEligibility(bridge bridgeName: String) throws {
        guard try self.existingBridges.contains(bridgeName) else {
            throw Iwstb.Error(because: "Not a bridge: \(bridgeName)")
        }
        guard !self.scBridges.contains(bridgeName) else {
            throw Iwstb.Error(because: """
                    Refusing to process a \
                    System Configuration bridge: \(bridgeName)
                    """)
        }
    }

    func checkEligibility<S: Sequence>(bridges bridgeNames: S)
            throws where S.Element == String {
        for bridgeName in bridgeNames {
            try checkEligibility(bridge: bridgeName)
        }
    }

    private func getSCBridgeNames() -> Set<String> {
        var bridgeNames = Set<String>()
        for iface in SCNetworkInterfaceCopyAll()
                as! Array<SCNetworkInterface> {
            guard let type = SCNetworkInterfaceGetInterfaceType(iface) as? String else {
                continue
            }
            guard type == "Bridge" else {
                continue
            }
            guard let name = SCNetworkInterfaceGetBSDName(iface) as? String else {
                continue
            }
            bridgeNames.insert(name)
        }
        return bridgeNames
    }

    private func getBridgeNames() throws -> Set<String> {
        var bridgeNames = Set<String>()
        for ifaddrPtr in try IfAddresses() {
            guard let name = String(cString: ifaddrPtr.pointee.ifa_name) else {
                throw Iwstb.Error(because: "Came across a nameless iface")
            }
            let addr = ifaddrPtr.pointee.ifa_addr.pointee
            let family = addr.sa_family
            guard family == AF_LINK else {
                continue
            }
            guard let data = UnsafeMutablePointer<if_data>(
                        rawPtr: ifaddrPtr.pointee.ifa_data,
                        ofType: if_data.self
            ) else {
                continue
            }
            guard data.pointee.ifi_type == IFT_BRIDGE else {
                continue
            }
            bridgeNames.insert(name)
        }
        return bridgeNames
    }
}
