cask "brink" do
  version "0.5.1"
  sha256 "6763ca0af62a00b61313a592aca941c8dfe9d667f120cee7950e4318109d0678"

  url "https://github.com/semihtalii/brink/releases/download/v#{version}/Brink.dmg"
  name "Brink"
  desc "Claude Code, Codex and Cursor usage limits on the edge of your screen"
  homepage "https://github.com/semihtalii/brink"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Universal binary (arm64 + x86_64) since 0.5.1.
  depends_on macos: :ventura

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
