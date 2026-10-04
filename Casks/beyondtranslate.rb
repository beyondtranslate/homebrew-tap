cask "beyondtranslate" do
  # Release assets are named after the full Flutter version, so the cask
  # version carries the build number too: `0.6.0,19` downloads
  # `beyondtranslate-0.6.0+19-macos.dmg`.
  version "0.6.0,19"
  sha256 "8aed189cfc03496f5eaaea7435570858623a100a8250351a378b90e70058e395"

  url "https://github.com/beyondtranslate/beyondtranslate-ce/releases/download/v#{version.csv.first}/beyondtranslate-#{version.csv.first}%2B#{version.csv.second}-macos.dmg"
  name "BeyondTranslate"
  desc "Translation and dictionary app"
  homepage "https://beyondtranslate.com/"

  livecheck do
    url :url
    regex(/^beyondtranslate[._-]v?(\d+(?:\.\d+)+)\+(\d+)[._-]macos\.dmg$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on macos: :ventura

  app "beyondtranslate.app"

  # The app is ad-hoc signed and not notarized, so Gatekeeper would refuse to
  # open the quarantined copy that Homebrew downloads.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/beyondtranslate.app"]
  end

  uninstall quit: "com.beyondtranslate.app"

  zap trash: [
    "~/Library/Application Support/com.beyondtranslate.app",
    "~/Library/Caches/com.beyondtranslate.app",
    "~/Library/HTTPStorages/com.beyondtranslate.app",
    "~/Library/Preferences/com.beyondtranslate.app.plist",
    "~/Library/Saved Application State/com.beyondtranslate.app.savedState",
  ]
end
