cask "brink" do
  version "0.5.0"
  sha256 "d4ccac85d796be331673b77b62482ba6a5742ca1c7f2c532bd7b6810a4ae29c7"

  url "https://github.com/semihtalii/brink/releases/download/v#{version}/Brink.dmg"
  name "Brink"
  desc "Claude Code, Codex and Cursor usage limits on the edge of your screen"
  homepage "https://github.com/semihtalii/brink"

  livecheck do
    url :url
    strategy :github_latest
  end

  # 0.5.0 shipped arm64-only; 0.6.0+ is a universal binary.
  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  app "Brink.app"

  # Not notarized yet: strip quarantine so Gatekeeper doesn't block the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Brink.app"],
                   sudo: false
  end

  uninstall quit: "com.semihtali.brink"

  zap trash: [
    "~/Library/Application Support/Brink",
    "~/Library/Preferences/com.semihtali.brink.plist",
  ]
end
