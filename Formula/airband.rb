# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.9.6"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.9.6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "29d456e47969c6bd0aef33a3ba6b02a8118e1abb660494a71ecbfe17c50dc169"
    sha256 cellar: :any_skip_relocation, big_sur:       "c3b5388271cbd93bbc7e0f79bfd80b62fd19d6d3e0bb69afdca90a0c70858463"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "330b847e8210caeffe5cf11abbdb3f0334b18bdb5106e8e8ea5c3a5f04f250ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bd1756d8e457dd74360cc78927edd8313db8be05b57e2b66f95957245a742d0c"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.9.6/airband-0.9.6-aarch64-apple-darwin.tar.gz"
      sha256 "51ef976acae4dfc9e8c951dcf90dcb2d8cd86f992a53f535c5e0cd6f765b70ba"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.6/airband-0.9.6-x86_64-apple-darwin.tar.gz"
      sha256 "a6e28414bcb0f96cf389c2a6d4befc6b9ca10f6c0e65a8546a18cc41dcdfb71d"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.9.6/airband-0.9.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "49de2e868971e77a596936c6eddbf90d2cbbb53a75a1030497d5967ff5662888"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.6/airband-0.9.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b2dec41108898815dd79bf0f718f5ba03a0fedeccb6b9a6c938b31a22a545cc7"
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
