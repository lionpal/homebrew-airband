# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.1.1"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "652404e0d9712be1a3a7f0b5a02b0ef61070e421a51866cabd3f92f739d16592"
    sha256 cellar: :any_skip_relocation, big_sur:       "79ed849410ffc6df8cc73c54f3261893109604870bdfd42a8ffdb51cdcf54b93"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3f5f09c4df8ffde876d107953778e08d7c7f8a1ef3e469e146b751d7178ced44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "59e94bfd871b6dd4f27de4f102534d4ff5f76055858725e8b47a843f6448acdc"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.1.1/airband-0.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "f0b460bdc207a2df04e479379d29ed0758bd598c089c04a67efef00a68b21956"
    end
    on_intel do
      url "https://airband.dev/releases/0.1.1/airband-0.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "152ba80c8783e6e4371b94b6280e5ef75b58baa9a6a673e5df161e62f831bb06"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.1.1/airband-0.1.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c0a82da3fdd86f7026e070a636864bdd163b65160d01b729cf4bf8b6b74e2d99"
    end
    on_intel do
      url "https://airband.dev/releases/0.1.1/airband-0.1.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3a6830363f36a6aaa6e65febdd9519a80c13b04ef4bdaee06c8a401958b37a8e"
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
