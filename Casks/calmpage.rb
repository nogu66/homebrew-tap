cask "calmpage" do
  version "0.3.0"
  sha256 "fa2e0ef6d95b27b91700923a06103fe13d57f8c516a6419e237f6819ea4b5b2e"

  url "https://github.com/nogu66/calmpage/releases/download/v#{version}/Calmpage-#{version}-arm64-mac.zip"
  name "Calmpage"
  desc "Quiet LaTeX editor with a live PDF preview"
  homepage "https://github.com/nogu66/calmpage"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :monterey"

  app "Calmpage.app"

  # The app is not notarized yet, so clear the quarantine flag Homebrew sets on downloads.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Calmpage.app"]
  end

  zap trash: [
    "~/Library/Application Support/Calmpage",
    "~/Library/Application Support/Sumi",
    "~/Library/Application Support/Sumitex",
    "~/Library/Preferences/me.noguchy.calmpage.plist",
    "~/Library/Preferences/me.noguchy.sumi.plist",
    "~/Library/Preferences/me.noguchy.sumitex.plist",
    "~/Library/Saved Application State/me.noguchy.calmpage.savedState",
    "~/Library/Saved Application State/me.noguchy.sumi.savedState",
    "~/Library/Saved Application State/me.noguchy.sumitex.savedState",
  ]

  caveats <<~EOS
    Calmpage compiles with latexmk. If you don't have TeX yet:
      brew install --cask mactex-no-gui
  EOS
end
