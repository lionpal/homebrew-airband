# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.8.0"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d9073066b17e78bd7178c0e08f96ac30562ac332f2b786ce06915c6a526ef100"
    sha256 cellar: :any_skip_relocation, big_sur:       "d7b48a1add10a8805a00aa375786bd3798ab2fc24f59db7bb9d37fa5c69c4bdf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9a6cc502c798a1984a751cec7a9795d15b5352c6d7f9d339915aa5d09ef6aced"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "626af7e64a1ee95e4b41d7c1e7cfc3045dc389ed337c117775bd885c79a2bdb6"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.8.0/airband-0.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "be7a7e5263138ff01ca4c9a4d45213fcd6a91aaf8b15c6f475b65e60320c5cc7"
    end
    on_intel do
      url "https://airband.dev/releases/0.8.0/airband-0.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "75dea5bd2b58b41481e2badc75a4b701e540f6f9d4f347556e285087993dce54"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.8.0/airband-0.8.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ca8c31b1391566402c9850b3eb3faf73d3d331bec545e8c1842ba04b338e254a"
    end
    on_intel do
      url "https://airband.dev/releases/0.8.0/airband-0.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6cb2846bfb22ecd5642c3622681e840c8db37d5469d06a3f46711a12097b5ad0"
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
