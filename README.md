Dead simple screenshot maker, that compatible with Wayland and X Window.

# Rationale

Shutter and ScreenCloud not work with Wayland because of security limitations of new architecture. The only app that works is `gnome-screenshot` utility.

Eventually Wayland will provide some API for taking screenshots. Currently simple workaround can be used.

# Features

- Upload screenshot files to Dropbox
- Short link via URL shortener
- URL is copied to clipboard

# How to setup

```bash
apt install httpie
apt install jq
```

Create `~/.screenshotsrc` file and define API key for Google URL Shortener in variable `GOO_GL_API_KEY`.

Optionally, extra variables can override default settings for `SCREENSHOTS_FOLDER`, `SCREENSHOT_FILENAME`.

Run script to make screenshot:

```bash
screenshot.sh
```

It is recommended to add hotkey for this script. E.g. Win+PrtSсr