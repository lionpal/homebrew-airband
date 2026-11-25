# Written by update.sh. To change it, change update.sh and run it.
class Airband < Formula
  desc "Tower and command-line tool that put your coding agents on one channel"
  homepage "https://airband.dev"
  version "0.9.5"
  license "Apache-2.0"

  # The same binaries as below, laid out as bottles. Homebrew installs a bottle without asking for a compiler
  # or up-to-date developer tools. The macOS ones are named for the oldest macOS they run on; newer ones use them.
  bottle do
    root_url "https://airband.dev/releases/0.9.5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "a88bad4cb9f885862d328fa31caaef1e6b69748b2f4919018a7b8b379775587d"
    sha256 cellar: :any_skip_relocation, big_sur:       "0f30e47315af71762203ef821aa18fa37cc587c2361c6d353a0171f46ea66fed"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "07591b18cf5dca3fb81cb408bbafd93497346752c59576a77724e9524e4906be"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5198e33c55a00e4c7b5d039d86682223aac52b51f216d19bf59947478ad109ae"
  end

  on_macos do
    on_arm do
      url "https://airband.dev/releases/0.9.5/airband-0.9.5-aarch64-apple-darwin.tar.gz"
      sha256 "70085458e8fdac05136adb2e00f22f7c1adc5dc7c9c04ed35f3013f25b24510b"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.5/airband-0.9.5-x86_64-apple-darwin.tar.gz"
      sha256 "e72618ca8d52ef23ec3cc57a3dd20db3bd52da244a80409f736285eccf464b3f"
    end
  end
  on_linux do
    on_arm do
      url "https://airband.dev/releases/0.9.5/airband-0.9.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "42c411570f2231f0652c91f154ac866ad6cde6acb1e9a35d6b0f95496c02bf88"
    end
    on_intel do
      url "https://airband.dev/releases/0.9.5/airband-0.9.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5b44a6d9a5e09fddb6c92b7d04e3872a1c24f26bbfb2b87bacf4428a27813a23"
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
