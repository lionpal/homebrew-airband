#!/bin/sh
# Write Formula/airband.rb for a released version of airband:
#   ./update.sh            the latest release (https://airband.dev/releases/latest.json)
#   ./update.sh 0.1.1      that version
# The checksums are read from https://airband.dev/releases/<version>/<file>.sha256.
set -eu
cd "$(dirname "$0")"
base=https://airband.dev/releases
version=${1:-$(curl -fsS "$base/latest.json" | sed -n 's/.*"version": *"\([0-9][0-9A-Za-z.+-]*\)".*/\1/p')}
[ -n "$version" ] || { echo "could not read the latest version" >&2; exit 1; }
sum() {
  s=$(curl -fsS "$base/$version/$1.sha256" | tr -d '[:space:]')
  echo "$s" | grep -Eq '^[0-9a-f]{64}$' || { echo "no checksum for $1" >&2; exit 1; }
  echo "$s"
}
mac_arm=$(sum "airband-$version-aarch64-apple-darwin.tar.gz")
mac_intel=$(sum "airband-$version-x86_64-apple-darwin.tar.gz")
linux_arm=$(sum "airband-$version-aarch64-unknown-linux-gnu.tar.gz")
linux_intel=$(sum "airband-$version-x86_64-unknown-linux-gnu.tar.gz")
bottle_mac_arm=$(sum "airband-$version.arm64_big_sur.bottle.tar.gz")
bottle_mac_intel=$(sum "airband-$version.big_sur.bottle.tar.gz")
bottle_linux_arm=$(sum "airband-$version.arm64_linux.bottle.tar.gz")
bottle_linux_intel=$(sum "airband-$version.x86_64_linux.bottle.tar.gz")
cat > Formula/airband.rb <<EOF
# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "$version"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "$base/$version"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "$bottle_mac_arm"
    sha256 cellar: :any_skip_relocation, big_sur:       "$bottle_mac_intel"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "$bottle_linux_arm"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "$bottle_linux_intel"
  end

  on_macos do
    on_arm do
      url "$base/$version/airband-$version-aarch64-apple-darwin.tar.gz"
      sha256 "$mac_arm"
    end
    on_intel do
      url "$base/$version/airband-$version-x86_64-apple-darwin.tar.gz"
      sha256 "$mac_intel"
    end
  end
  on_linux do
    on_arm do
      url "$base/$version/airband-$version-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "$linux_arm"
    end
    on_intel do
      url "$base/$version/airband-$version-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "$linux_intel"
    end
  end

  def install
    bin.install "airband"
  end

  # No service block on purpose. \`airband install\` writes its own login item (dev.airband.tower), and a
  # second one from \`brew services\` would start a second tower on the same port.
  def caveats
    <<~EOS
      To set airband up, run once:
        airband install
      It adds hooks to Claude Code and starts the tower at login (macOS).
      Do not use \`brew services\` for airband: \`airband install\` is what starts it.

      After \`brew upgrade airband\`, run \`airband install\` again to restart the tower.
      Before \`brew uninstall airband\`, run \`airband uninstall\`.
    EOS
  end

  test do
    assert_equal "airband #{version}", shell_output("#{bin}/airband --version").strip
  end
end
EOF
echo "Formula/airband.rb is at $version"
