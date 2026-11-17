# DeyeCloudWidget - iOS Widget for Deye Cloud

DeyeCloudWidget is a SwiftUI/WidgetKit iOS app and Home Screen widget for checking a Deye Cloud solar installation at a glance. It connects to the Deye Cloud API and displays generated power, consumed power, system status, and the last update time. The app and widget share configuration and cached data through an App Group.

> **Status:** The repository contains the Swift sources and a GitHub Actions workflow that generates an unsigned IPA. A signed build is required before iOS will install it on a device.

## Features

- Compact and regular widget sizes.
- Generated and consumed power in kW.
- Online, offline, error, and standby status indicators.
- Automatic timeline refresh (approximately every 15 minutes; iOS controls the exact schedule).
- Cached values for useful display when the network is unavailable.
- API Key and Device ID configuration in the companion app.
- Shared app/widget storage using `group.com.deyecloud.widget`.
- Manual refresh and credential clearing from the app.

## Requirements

- iPhone or iPad running **iOS 17.0 or later**.
- A Deye Cloud account, API Key, and Device ID for a compatible installation.
- Internet access for the app/widget to retrieve current values.
- For building: macOS, Xcode with iOS 17 SDK support, and an Apple Developer account for device installation/signing.
- The repository does not include an `.xcodeproj`; `generate-xcode-project.sh` creates it on macOS.

## Installation

Choose one of the following options.

### Option A: Download a pre-built IPA from GitHub Actions/Releases

1. Open the repository's [Actions](https://github.com/MaSaCalderone/DeyeCloudWidget/actions) page and select a successful **Build iOS Widget** run, or open the [Releases](https://github.com/MaSaCalderone/DeyeCloudWidget/releases) page.
2. Download `DeyeCloudWidget.ipa` from the workflow artifact or release assets.
3. Sign the IPA with your own Apple Developer certificate/profile, or install it through a compatible sideloading tool (for example, AltStore or Sideloadly). The workflow intentionally builds with code signing disabled, so the downloaded IPA is not directly installable by itself.
4. Trust/enable the developer profile on the iPhone if iOS asks: **Settings > General > VPN & Device Management**.
5. Open the installed app and configure the Deye Cloud credentials (see [Initial setup](#initial-setup)).

Releases are created automatically by the workflow when it runs on `main`; if no release or successful run is available, use Option B.

### Option B: Build from source with Xcode

1. On a Mac, install Xcode and clone the repository:

   ```bash
   git clone https://github.com/MaSaCalderone/DeyeCloudWidget.git
   cd DeyeCloudWidget
   ```

2. Generate the Xcode project. The script creates `~/Desktop/DeyeCloudWidget` and asks whether to open it:

   ```bash
   chmod +x generate-xcode-project.sh
   printf 's\n' | ./generate-xcode-project.sh DeyeCloudWidget
   open ~/Desktop/DeyeCloudWidget/DeyeCloudWidget.xcodeproj
   ```

   To answer manually, run `./generate-xcode-project.sh DeyeCloudWidget` and enter `s` when prompted.
3. In Xcode, select the **DeyeCloudWidget** app target and the widget extension target. Set your Apple Developer **Team** and use unique bundle identifiers if necessary.
4. In **Signing & Capabilities** for both targets, add the App Groups capability and enable `group.com.deyecloud.widget`. The same group is required for app/widget synchronization.
5. Confirm the deployment target is iOS 17.0 or later, connect a device or choose a simulator, then select the **DeyeCloudWidget** scheme.
6. Choose **Product > Build** (`Cmd+B`) and then **Product > Run** (`Cmd+R`). For a physical device, Xcode signs and installs the app using your team.
7. Complete [Initial setup](#initial-setup).

> The generator creates a starter Xcode project from the repository sources. Review the generated project and signing settings before distributing a build.

### Option C: TestFlight (beta testing)

TestFlight is available only when the project owner publishes a beta build; it is not automatically enabled by the repository workflow.

1. Ask the maintainer for an active TestFlight invitation or public link.
2. Install **TestFlight** from the App Store on an iOS 17+ device.
3. Open the invitation link, tap **View in TestFlight**, then tap **Accept** and **Install**.
4. Launch DeyeCloudWidget and complete [Initial setup](#initial-setup).
5. Install updates from TestFlight while the beta is available. TestFlight builds expire after the period shown by Apple.

## Initial setup

1. Sign in to [Deye Cloud](https://www.deyecloud.com).
2. Open the API settings and create/copy an API Key. Locate and copy the Device ID for the installation you want to monitor.
3. Open DeyeCloudWidget, choose **Configure Credentials**, and enter both values.
4. Save the credentials and use **Update Widget Now** if you want to request an immediate refresh.
5. Do not share the API Key or commit it to source control. The app stores the values in the shared App Group for the app and widget.

## Add the widget to the Home Screen

1. First open the app and save valid credentials.
2. Touch and hold an empty area of the Home Screen until the icons jiggle.
3. Tap **+**, search for **Deye Cloud**, and select it.
4. Swipe to choose the compact or regular size, then tap **Add Widget**.
5. Tap **Done**. Values update according to iOS WidgetKit scheduling, normally about every 15 minutes.

## Troubleshooting

- **The IPA will not install:** The GitHub Actions IPA is unsigned. Sign it with your Apple Developer credentials or use a supported sideloading tool; alternatively build and run from Xcode.
- **The widget does not appear:** Confirm the device is on iOS 17+, the widget target built successfully, and both targets use the App Group `group.com.deyecloud.widget`. Restarting the device can refresh the widget gallery.
- **The widget shows no data:** Open the app, verify the API Key and Device ID, save them again, and tap the manual refresh action. Check internet access and the Deye Cloud service.
- **App and widget do not share settings:** Check that the exact same App Group is enabled for both targets and that the app was reinstalled after changing signing/capabilities.
- **Signing or provisioning errors in Xcode:** Select your Apple Developer Team, use unique bundle IDs, enable automatic signing, and ensure the device is registered with the team.
- **Data is stale:** Widget refresh timing is controlled by iOS and is not guaranteed. Open the app to refresh and allow network access; cached data may be shown offline.
- **API requests fail:** Confirm the credentials have not expired or been revoked. Do not paste credentials into an issue; redact logs and sensitive values.

## Report an issue

Before opening an issue, search existing [issues](https://github.com/MaSaCalderone/DeyeCloudWidget/issues) and update to the latest build. Include:

- iOS version and device model.
- App/widget version or commit and installation method.
- Exact steps to reproduce and expected versus actual behavior.
- Relevant, redacted Xcode or Console logs.

**Never include API Keys, Device IDs, certificates, provisioning profiles, or other private data.** Use a private channel if a report requires sensitive information.

## License

This repository currently does not include a `LICENSE` file or an explicit open-source license. Until the copyright holder publishes one, all rights are reserved; do not redistribute or reuse the source beyond permissions granted by the repository owner. A future license will be documented here.

## Links

- [Deye Cloud](https://www.deyecloud.com)
- [GitHub Actions](https://github.com/MaSaCalderone/DeyeCloudWidget/actions)
- [Releases](https://github.com/MaSaCalderone/DeyeCloudWidget/releases)
- [WidgetKit documentation](https://developer.apple.com/documentation/widgetkit)
