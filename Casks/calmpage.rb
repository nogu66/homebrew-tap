cask "calmpage" do
  version "0.4.1"
  sha256 "03a0ceeb86eeb3f38bba1c2de774d1b58514de63f366be244c1cb38857ecd8a7"

  url "https://github.com/nogu66/calmpage/releases/download/v#{version}/Calmpage-#{version}-arm64-mac.zip"
  name "Calmpage"
  desc "Quiet LaTeX editor with a live PDF preview"
  homepage "https://github.com/nogu66/calmpage"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Calmpage.app"

  # The app is not notarized yet, so clear the quarantine flag Homebrew sets on downloads.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Calmpage.app"],
        writable_paths: ["Calmpage.app"],
        writable_base:  :appdir
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
