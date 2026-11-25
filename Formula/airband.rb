# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.9.8"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.9.8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1aabbb9f66977e1c85a5c83bdaf6fdbce17bccef04ebf96f7fa0e5f1b3f78d8b"
    sha256 cellar: :any_skip_relocation, big_sur:       "d0b47048f2884d202f086f6e2941e4fc7e7cced335a66fd166f62da61aca22d8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ea5b406f3564fc63864f7b61d494c352348684034fd58cf47533c3ccd757d284"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b74320d19724415dfb292ff9eea890a80538c716e630626bf429f5d1d2b55adf"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.9.8/airband-0.9.8-aarch64-apple-darwin.tar.gz"
      sha256 "22c5630451353f53c0796ee6b6b0952efda7ba22735ff5fbc9d6eb703fc0c139"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.8/airband-0.9.8-x86_64-apple-darwin.tar.gz"
      sha256 "634fc8f70362390ac4b167eaba4ea2997b415f222ee7f71478666e2d14409c65"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.9.8/airband-0.9.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eb4481b97f34284c6eab9b746ccfc046594637c7d7d3d183431a87a7ad63d832"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.8/airband-0.9.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1674b3b20bddeccc75eae1c0bf979334b50f5d0f330e670e1668fad813f6be88"
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
