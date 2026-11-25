# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.9.7"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.9.7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d9b54988987cdd887c9f95db05767cf6eefe3e5a6038deee6d52ba433ebd6c63"
    sha256 cellar: :any_skip_relocation, big_sur:       "eb632b4d185e61777194e242d3ba632ad58207b7db07a81ab9b664e9df0abc79"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7028a435701b6b31ccfab127ddfc4bbdf6327e04ce8b2f9d139008d4d5456f43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a9cb703eb552dd321c78c243a74bd91dc662e44f231a2b776453f7c025afcda5"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.9.7/airband-0.9.7-aarch64-apple-darwin.tar.gz"
      sha256 "03ca6d611c685dc5c8d9223918b04b07935c21560e05ff66bc569d7a53ff2573"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.7/airband-0.9.7-x86_64-apple-darwin.tar.gz"
      sha256 "2ac7f4b0b7a349cf7598e4105100775065799f40f4af65311609ff622433baca"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.9.7/airband-0.9.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5bde5ccb8e0f6f935f087da98f1396b42f6c261558780d7877d6747921971e52"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.7/airband-0.9.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c3705d7b693e91acf7be73f0fc5ee6371e5bdbf2077bc903728d110916c4ce18"
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
