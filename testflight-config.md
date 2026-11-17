# TestFlight beta distribution

This guide describes the supported path for publishing **DeyeCloudWidget** to TestFlight. The repository stores Swift sources and generates `DeyeCloudWidget.xcodeproj` with `generate-xcode-project.sh`; it does not store signing certificates, provisioning profiles, or App Store Connect credentials.

## Requirements

- An Apple Developer Program membership and an App Store Connect user with permission to upload builds.
- A registered App ID for the app and a separate App ID for the widget extension. The generated defaults are `com.example.deyecloud` and `com.example.deyecloud.widget`; change them to identifiers owned by your team if necessary.
- The `group.com.deyecloud.widget` App Group enabled for both identifiers.
- An Apple Distribution certificate and private key (normally exported as a password-protected `.p12`).
- App Store provisioning profiles for both the app and widget extension, matching the bundle IDs, team, App Group entitlement, and distribution certificate.
- A Mac/Xcode installation for local distribution, or the GitHub Actions macOS runner and the secrets listed in [secrets-setup.md](secrets-setup.md).

Never commit certificates, profiles, API keys, passwords, or Deye Cloud credentials.

## Configure App Store Connect

1. Sign in to [App Store Connect](https://appstoreconnect.apple.com/) and accept any agreements under **Business**.
2. Open **My Apps**, select **+ > New App**, choose iOS, and use the exact bundle ID, app name, SKU, and primary language. The app record must exist before the first upload.
3. In **Users and Access > Integrations > App Store Connect API**, create an API key with **Developer** or **App Manager** access. Download the `.p8` file once and record its Key ID and Issuer ID. Prefer this key for CI.
4. In **Certificates, Identifiers & Profiles** in the Apple Developer portal, register both App IDs and enable App Groups. Create/update the distribution certificate and App Store profiles.
5. In App Store Connect, configure **TestFlight > App Information**, export compliance, beta app description, feedback email, and contact information.
6. Add internal testers under **TestFlight > Internal Testing**. For external testers, create a group under **External Testing**, add testers or enable a public link, and submit the build for Beta App Review when Apple requests it.

The app and widget bundle IDs, Team ID, profiles, and App Group must agree. A mismatch causes signing or upload failure.

## Local build and upload

1. On macOS, install Xcode and Ruby/Fastlane, then clone the repository.
2. Generate and review the project:

   ```bash
   chmod +x generate-xcode-project.sh
   printf 'n\n' | ./generate-xcode-project.sh DeyeCloudWidget
   open "$HOME/Desktop/DeyeCloudWidget/DeyeCloudWidget.xcodeproj"
   ```

3. Set the Team and signing configuration on both targets. Confirm the app and widget use the intended App IDs and `group.com.deyecloud.widget`. Set `CFBundleShortVersionString` to the marketing version and increment `CFBundleVersion` for every upload.
4. Select the **DeyeCloudWidget** scheme, choose **Any iOS Device**, and select **Product > Archive**.
5. In Organizer, choose **Distribute App > App Store Connect > Upload**, review signing/export compliance, and upload. Alternatively, export an IPA and run `fastlane pilot upload --ipa path/to/DeyeCloudWidget.ipa`.
6. Wait for processing in App Store Connect. Complete export compliance and beta metadata before distributing the build.

## GitHub Actions upload

The workflow at `.github/workflows/testflight-upload.yml` runs for a newly created GitHub release. It generates the Xcode project, imports the distribution certificate/profiles, archives the app, and uploads the IPA using Fastlane Pilot (the App Store Connect upload action). Create the secrets in [secrets-setup.md](secrets-setup.md), then create a release in GitHub. Do not use a draft release as the upload trigger.

## Joining as a beta tester

1. Install **TestFlight** from the App Store on an iPhone or iPad running iOS 17 or later.
2. Accept the email invitation or open the public TestFlight link supplied by the maintainer.
3. Tap **View in TestFlight**, then **Accept** and **Install**.
4. Launch DeyeCloudWidget and enter the Deye Cloud API key and Device ID. TestFlight builds expire after the period shown in the app (normally 90 days).

Internal testers can install after processing; external testers may need Beta App Review first. Testers should report feedback through TestFlight and should not put API keys in issue reports.
