# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.5.0"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1c3b4442f7582045643d25169475a6990b8008a85061ddab42e154d8f9c1d6a8"
    sha256 cellar: :any_skip_relocation, big_sur:       "9b653dec401e145aa1a5ccfdf5c6afd2ec8080b8a317d702943ab168536a1066"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1553b16e31fa21b99f918f0f19658106e640fe7bf59d9d97ca4a5e26eeeca2d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e425c43b51fc70828287028c1a2a45fa654c395957478fe2d21aafb97691a4ba"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.5.0/airband-0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "8eb7cf4e09d0482ade23fce606a994b5b6107742b4c0258bacc4c9597696fc41"
    end
    on_intel do
      url "https://airband.dev/releases/0.5.0/airband-0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "db7295055eec8ba8edd70887b5752b893c7c1f66d98af9b8ce7785f61a48cbab"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.5.0/airband-0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "118afec9f40ab312897b12e23e635dd4d69d29ab2ea16e5816193b62727f3fda"
    end
    on_intel do
      url "https://airband.dev/releases/0.5.0/airband-0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cc06a3ccab4bf85e2cd5dfc9f4f8f605157a735f32671902ffd512251f0493d8"
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
