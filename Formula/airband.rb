# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.3.0"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "921f604ea35c23ea0f9b1ee592b03b05b3705b94b90001fefa05e98a1740aaf8"
    sha256 cellar: :any_skip_relocation, big_sur:       "6cb0f3aa1f9f7daf60200e43014980f5d6ad115ac9e74acbd55c4d73b8b4de00"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ed1251c9b2f46399d57a9631bad46698be0d5f7a0a9658738b5a4b2140617c5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c259a9730bddac9c155894e88a01941be7d2b0563fb021bd4f13d50a292b0010"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.3.0/airband-0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "aeaa2590e60880000eb812e6e858c0866eebdfe1ccdd088f730a0a1a46876aed"
    end
    on_intel do
      url "https://airband.dev/releases/0.3.0/airband-0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "e06e9d874a2e7161d0b5038f7faa0b053e5baf9f1d3075ca956e1097461c1958"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.3.0/airband-0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aed8810fc3307d91334793d8b866cf9fed8df3d9bbe035a24deafe27feddd41e"
    end
    on_intel do
      url "https://airband.dev/releases/0.3.0/airband-0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8b301faa41413c9d0448638dcab364af649aa49499386a7439a1e66b23b0c6b9"
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
