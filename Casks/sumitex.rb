cask "sumitex" do
  version "0.1.0"
  sha256 "1faa98e79d02734f566e5a4acb88e2ab1bee1b45d848e6962626534f389fad28"

  url "https://github.com/nogu66/sumitex/releases/download/v#{version}/Sumi-#{version}-arm64-mac.zip"
  name "Sumi TeX"
  desc "Quiet LaTeX editor with a live PDF preview"
  homepage "https://github.com/nogu66/sumitex"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Sumi.app"

  # The app is not notarized yet, so clear the quarantine flag Homebrew sets on downloads.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Sumi.app"]
  end

  zap trash: [
    "~/Library/Application Support/Sumi",
    "~/Library/Application Support/sumi",
    "~/Library/Preferences/me.noguchy.sumi.plist",
    "~/Library/Saved Application State/me.noguchy.sumi.savedState",
  ]

  caveats <<~EOS
    Sumi TeX compiles with latexmk. If you don't have TeX yet:
      brew install --cask mactex-no-gui
  EOS
end
