import Foundation
import Iwstb

Iwstb.updateUsage(with:
    """
    Usage:
      $PROG <command> [[<iface>] …]

      Facilitattes unprivileged bridge management.
      Run “$PROG help” for details.\u{2702}

    List existing bridges:
      $PROG list

    Create a new bridge:
      $PROG create
      # Prints new bridge name to stdout

    Destroy a bridge:
      $PROG destroy <bridge> [<bridge> …]

    Add iface(s) to a bridge:
      $PROG addm <bridge> <iface> [<iface> …]

    Remove iface(s) from a bridge:
      $PROG deletem <bridge> <iface> [<iface> …]

    Mark a bridge “up”:
      $PROG up <bridge> [<bridge> …]

    Mark a bridge “down”:
      $PROG down <bridge> [<bridge> …]

    Test priviliges:
      $PROG test
      # Exits with non-zero status if lacks priviliges

    Examples:
      BRIDGE=$($PROG create)
      if [ -n "$BRIDGE" ]; then
          $PROG addm $BRIDGE tap0 tap1
          $PROG up $BRIDGE
          # do something
          $PROG destroy $BRIDGE
      fi

    Installation:
      1. Put $PROG in a directory which is:
         * owned by root
         * writable only by root
         * all its parent directories up to the file sysytem root are also
           owned and writable only by root
      2. Make root owner of $PROG
      3. Set SUID bit on $PROG
    """
)


fileprivate func main() -> Int32 {
    do {
        let processor = try cookCommandProcessor(for: CommandLine.arguments)
        return try processor.process()
    } catch {
        return Iwstb.brag(error, exitCode: 127)
    }
}

exit(main())
