# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.9.9"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.9.9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "6b7db44aef9d0dc4f29434492c0cb729bc7176a13c739958eb3bbfbcc438351c"
    sha256 cellar: :any_skip_relocation, big_sur:       "a8dd50fe967d39a86b03e69d1f9655a2e60f678bd4e8d2d1c9003697f1bbfdf7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "03db4dc3ba2b61ddfeb789c2eb8c977e86d74b5c7f9852a6cf4a64fbd0703186"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "88e25dfd6f3ef8fb317c57b6ab4b27f35b01b923510541705fffa46598bc3431"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.9.9/airband-0.9.9-aarch64-apple-darwin.tar.gz"
      sha256 "9320ace5faf937c19b0424a4ea4fe48bf5f09755f8858192f915ca0c391530c8"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.9/airband-0.9.9-x86_64-apple-darwin.tar.gz"
      sha256 "6eecf076572fb9fa42547b4beef206ef9411aaf120745d94710ff1898ba6787e"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.9.9/airband-0.9.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1ee925c68c3d28260814291348bc7f8f2135d5b9b18b33015361b3e989115ee7"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.9/airband-0.9.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fe4e1c57b78e59384d5cfc17c608d94a3649d370606005e5445e72c6e0c43cb7"
    end
  end

  def install
    bin.install "airband"
  end

  # No service block on purpose. `airband install` writes its own login item (dev.airband.tower), and a
  # second one from `brew services` would start a second tower on the same port.
  def caveats
    <<~EOS
      To set airband up, run once:
        airband install
      It adds hooks to Claude Code and starts the tower at login (macOS).
      Do not use `brew services` for airband: `airband install` is what starts it.

      After `brew upgrade airband`, run `airband install` again to restart the tower.
      Before `brew uninstall airband`, run `airband uninstall`.
    EOS
  end

  test do
    assert_equal "airband #{version}", shell_output("#{bin}/airband --version").strip
  end
end
