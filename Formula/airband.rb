# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.7.0"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "451c7f08069cf69962de3dd40b8c8ad0c6cf96845dd55495f10a146362ac45e1"
    sha256 cellar: :any_skip_relocation, big_sur:       "172b8aa8ba14ea24ad9cb2f2f05dac7027b0583eb4657396c18a52f36470882c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bf43962ef880e7f2abcddc75487f024fe25f9e582b7e6f1d3da8bde3591896f6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c89e0cbd6c3e729bf00c2a27a6cd1d9d98adb72134569840dab05712d5929fdb"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.7.0/airband-0.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "f0f470f72a41d9e043111c38d190651ee8a9dcbaf16a10ae9a2c8b2f21cf65fa"
    end
    on_intel do
      url "https://airband.dev/releases/0.7.0/airband-0.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "b032a12e63c28e073f040918c5368bc811cf1997c2d2139cf7e26bbb141c9f55"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.7.0/airband-0.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fc56fd8be2721d4c13bc8072b20d2e819254e550a50e4520fac1ecfbacc64826"
    end
    on_intel do
      url "https://airband.dev/releases/0.7.0/airband-0.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a3ea8203e3ce448374a144c18acd47c52069e73b51777457b69615b78c38bfb5"
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
