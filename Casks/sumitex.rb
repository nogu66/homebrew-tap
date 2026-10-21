cask "sumitex" do
  version "0.2.0"
  sha256 "0c279f118a80fcdcd6f3aedbc858c45874227d0bc701fe119055683368e2224a"

  url "https://github.com/nogu66/sumitex/releases/download/v#{version}/Sumitex-#{version}-arm64-mac.zip"
  name "Sumitex"
  desc "Quiet LaTeX editor with a live PDF preview"
  homepage "https://github.com/nogu66/sumitex"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Sumitex.app"

  # The app is not notarized yet, so clear the quarantine flag Homebrew sets on downloads.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Sumitex.app"]
  end

  zap trash: [
    "~/Library/Application Support/Sumi",
    "~/Library/Application Support/Sumitex",
    "~/Library/Preferences/me.noguchy.sumi.plist",
    "~/Library/Preferences/me.noguchy.sumitex.plist",
    "~/Library/Saved Application State/me.noguchy.sumi.savedState",
    "~/Library/Saved Application State/me.noguchy.sumitex.savedState",
  ]

  caveats <<~EOS
    Sumitex compiles with latexmk. If you don't have TeX yet:
      brew install --cask mactex-no-gui
  EOS
end
