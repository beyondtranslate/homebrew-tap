cask "beyondtranslate-ce" do
  # Release assets are named after the full Flutter version, so the cask
  # version carries the build number too: `0.6.0,19` downloads
  # `beyondtranslate-0.6.0+19-macos.dmg`.
  version "0.6.0,19"
  sha256 "8aed189cfc03496f5eaaea7435570858623a100a8250351a378b90e70058e395"

  url "https://github.com/beyondtranslate/beyondtranslate-ce/releases/download/v#{version.csv.first}/beyondtranslate-#{version.csv.first}%2B#{version.csv.second}-macos.dmg"
  name "BeyondTranslate CE"
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

  # The bundle is named after `APP_PRODUCT_NAME` in the app's
  # `macos/Runner/Configs/Edition.xcconfig`; keep the two in step.
  app "BeyondTranslate-CE.app"

  # The app is ad-hoc signed and not notarized, so Gatekeeper would refuse to
  # open the quarantined copy that Homebrew downloads.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/BeyondTranslate-CE.app"]
  end

  uninstall quit: "com.beyondtranslate.appce"

  # 0.6.0 shipped as `beyondtranslate.app` under the `com.beyondtranslate.app`
  # bundle id and left its data there; zap clears both generations.
  zap trash: [
    "~/Library/Application Support/com.beyondtranslate.appce",
    "~/Library/Caches/com.beyondtranslate.appce",
    "~/Library/HTTPStorages/com.beyondtranslate.appce",
    "~/Library/Preferences/com.beyondtranslate.appce.plist",
    "~/Library/Saved Application State/com.beyondtranslate.appce.savedState",
    "~/Library/Application Support/com.beyondtranslate.app",
    "~/Library/Caches/com.beyondtranslate.app",
    "~/Library/HTTPStorages/com.beyondtranslate.app",
    "~/Library/Preferences/com.beyondtranslate.app.plist",
    "~/Library/Saved Application State/com.beyondtranslate.app.savedState",
  ]
end
