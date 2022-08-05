# Bridge manager for unprivileged users

A wrapper for macOS ifconfig. Facilitates bridge manipulations by unprivileged users.

## Warning
This program is intended to provide non-root access to network settings on 
macOS. It is by design restricted to a few bridge-related manipulations but 
still it **reduces** security. Please do not use this program unless you do
understand its implications and are okay with them.

## Usage
```bash
bridger <command> [[<iface>] …]
```

## Commands
### List existing bridges
```bash
bridger list
```

### Create a new bridge
Prints new bridge name to stdout
```bash
bridger create
```

### Destroy a bridge
```bash
bridger destroy <bridge> [<bridge> …]
```

### Add iface(s) to a bridge
```bash
bridger addm <bridge> <iface> [<iface> …]
```

### Remove iface(s) from a bridge
```bash
bridger deletem <bridge> <iface> [<iface> …]
```

### Mark a bridge “up”
```bash
bridger up <bridge> [<bridge> …]
```

### Mark a bridge “down”
```bash
bridger down <bridge> [<bridge> …]
```

### Test privileges
Exits with non-zero status if lacks privileges
```bash
bridger test
```

### Get help
```bash
  bridger help
```


## Examples
```bash
BRIDGE=$(bridger create)
if [ -n "$BRIDGE" ]; then
  bridger addm $BRIDGE tap0 tap1
  bridger up $BRIDGE
  # do something
  bridger destroy $BRIDGE
fi
```

## Building
Xcode 13 is required or probably just a standalone Swift will do.
```bash
git clone https://github.com/optimistiCli/bridger.git
cd bridger
swift build -c release
./.build/release/bridger help
```

## Installation:
1. Put bridger in a directory which is:
    * owned by root
    * writable only by root
    * all its parent directories up to the file system root are also owned and writable only by root
1. Make root owner of bridger
1. Set SUID bit on bridger

I.e. something like this:
```bash
sudo mkdir -p /usr/local/sbin
sudo chmod 755 /usr/local/sbin
sudo cp -iv .build/release/bridger /usr/local/sbin/
sudo chown root:wheel /usr/local/sbin/bridger
sudo chmod a+s /usr/local/sbin/bridger
PATH="$PATH":/usr/local/sbin
bridger test
```

## Disclaimer
You can use this program in any manner that suits you though remember at all 
times that by using it you agree that you use it at your own risk and neither 
I nor anybody else except for yourself is to be held responsible in case 
anything goes wrong as a result of using this program.

## Links
Something to read at leasure :stuck_out_tongue_winking_eye:
### Enumerating faces
* [BridgeConfiguration.c](https://opensource.apple.com/source/configd/configd-395.6/SystemConfiguration.fproj/BridgeConfiguration.c.auto.html)
* [MAC address with getifaddrs](https://stackoverflow.com/questions/6762766/mac-address-with-getifaddrs/)
* [getifaddrs(3)](https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man3/getifaddrs.3.html)
* [Enumerating available interfaces for use with NWEthernetChannel](https://developer.apple.com/forums/thread/676729)
* [SCNetworkInterfaceCopyAll](https://developer.apple.com/documentation/systemconfiguration/1517090-scnetworkinterfacecopyall)
* `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/net/if_types.h`
* `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/net/sys/errno.h`
* [swift-netutils/NetUtils/Interface.swift](https://github.com/svdo/swift-netutils/blob/master/NetUtils/Interface.swift)

### You might also find these enticing
* [Making a program always run as root in OS X](https://superuser.com/questions/457868/making-a-program-always-run-as-root-in-os-x)
* [Using Tunnelblick to load tun/tap kext](https://github.com/Tunnelblick/Tunnelblick/issues/703)
* User groups manipulations in macOS: `man dseditgroup`
