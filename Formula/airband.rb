# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.2.0"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c11e8f87627404954407774d6fb9761c8674c162286c6e6547b0d5c7411cc07a"
    sha256 cellar: :any_skip_relocation, big_sur:       "877d032154b778cf90784ccac8fc87ef97772a7ab8846bbe5e830d363cd97540"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "380945a5ba9647aa33ce5eb600d628a630fad274503b47aca89aab9a17971bd8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d6fdde32b8c54a2a038db09fe9d665e9c9a758e847cbd8217cc38fe0e2792d7f"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.2.0/airband-0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "d58d209bdcafb0a672500583fb168ad0479bedf1f03e3733959800054684ccbd"
    end
    on_intel do
      url "https://airband.dev/releases/0.2.0/airband-0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "186f15211fdd5b34a27368901201f6a1614abc7e1a25f843f854c98e18faa390"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.2.0/airband-0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "41bd4edb36b4f0a7878c5bd165619113c67fb344289acf2e472bf75b78b1f93b"
    end
    on_intel do
      url "https://airband.dev/releases/0.2.0/airband-0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b00d44db3f6d6662e3ca48ecc5c88a8e4d5834abd7535f20cc6fb98bbf158cf2"
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
