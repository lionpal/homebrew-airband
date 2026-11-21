# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.4.0"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.4.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4a6f851861a02a0d6d99db690284561d4b313b783f286d856481d9af5ba26e96"
    sha256 cellar: :any_skip_relocation, big_sur:       "403025d7adf120284b1128e1e8731a45b055c1e6c0531334d2a6d528d4ca2ff4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f193bf663318fc6862864ca4859bd24bf4269d0ce52fde4d25eee7bb4da5694b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "863bc6db0444a5d2b1e19e5a489b5aa9bdad4a5a0e90a36b9f5b2bc241344d42"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.4.0/airband-0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "37dfb4abda0d3d3b04562fa6f9d1183db7fa19d314da7289d7ddfb9a3b6bc468"
    end
    on_intel do
      url "https://airband.dev/releases/0.4.0/airband-0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "10c4903b9dd282e1338897f25b77d5521967ba8ffbf6ebb5e35a717e4f0b9c62"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.4.0/airband-0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1077917d69980bdd7a9ff8ab10cdb2fdc318b84ab87bac71adde6cb413ad1182"
    end
    on_intel do
      url "https://airband.dev/releases/0.4.0/airband-0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "00528dff95ec325aaa9a965f8bece65888153b729f8f275f36fece3478b7c9a6"
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
