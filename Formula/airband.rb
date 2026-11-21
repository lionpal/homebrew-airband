# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.6.0"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a4d742c337ee8ce05ca70ddfe89352708554d1260983380522efa435df53ea5a"
    sha256 cellar: :any_skip_relocation, big_sur:       "c96748f2db9044a9d68a61cf1f29c688bac8db418abe943f53d9050aabdea631"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d7362f1bcd11b5af86682719fcea2bda3aec6b22168dc4de8e6874ae7a50fdc8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4079b411e2c17ff366e4422d2cd455b15951cd6cbaaaa5d653c845b0220965c"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.6.0/airband-0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "27706dbafe5ffd081160856452046fbc97956db3c603d132501b0345955d3fe3"
    end
    on_intel do
      url "https://airband.dev/releases/0.6.0/airband-0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "84b381fbf94b918687e69b29fa4be873b5f2696841d25a4e829439460c9e3ccb"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.6.0/airband-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5120898379fbe84b8b99a3fe498c61fabfd0d734ecddbc7036e1974d445d47a3"
    end
    on_intel do
      url "https://airband.dev/releases/0.6.0/airband-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "318d202093eca899d76e2ca16f433b6ca7701679ab8a351833636d435bfdf419"
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
