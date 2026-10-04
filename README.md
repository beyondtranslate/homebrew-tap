# BeyondTranslate Homebrew Tap

Homebrew cask for [BeyondTranslate](https://beyondtranslate.com/), a
translation and dictionary app for macOS.

## Install

```bash
brew install --cask beyondtranslate/tap/beyondtranslate
```

Or tap first, then install by name:

```bash
brew tap beyondtranslate/tap
brew install --cask beyondtranslate
```

## Update

```bash
brew upgrade --cask beyondtranslate
```

## Uninstall

```bash
brew uninstall --cask beyondtranslate
```

Add `--zap` to also remove settings and caches.

## Maintenance

The cask follows the latest release of
[beyondtranslate-ce](https://github.com/beyondtranslate/beyondtranslate-ce/releases).
The [Update](.github/workflows/update.yml) workflow checks for a new release
every six hours, and the app's release workflow dispatches it as soon as a
release is published. To bump the cask by hand:

```bash
gh workflow run update.yml --repo beyondtranslate/homebrew-tap
```
