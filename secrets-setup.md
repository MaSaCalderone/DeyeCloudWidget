# GitHub Secrets for TestFlight

Create these repository or environment secrets under **Settings > Secrets and variables > Actions**. Use a protected `production` environment if releases require approval. Secret values are never written to the repository.

## Required signing secrets

| Secret | Value |
|---|---|
| `APPLE_CERTIFICATE_BASE64` | Base64 of the password-protected Apple Distribution `.p12` containing its private key. |
| `APPLE_CERTIFICATE_PASSWORD` | Password used to export/open that `.p12`. |
| `APP_PROVISIONING_PROFILE_BASE64` | Base64 of the App Store provisioning profile (`.mobileprovision`). |
| `WIDGET_PROVISIONING_PROFILE_BASE64` | Base64 of the Widget App Store provisioning profile. |
| `APP_PROVISIONING_PROFILE_NAME` | Exact profile name for the app target. |
| `WIDGET_PROVISIONING_PROFILE_NAME` | Exact profile name for the widget target. |
| `TEAM_ID` | Apple Developer Team ID (10-character value). |
| `APP_BUNDLE_IDENTIFIER` | App bundle ID, for example `com.example.deyecloud`. |
| `WIDGET_BUNDLE_IDENTIFIER` | Widget bundle ID, for example `com.example.deyecloud.widget`. |

The profiles must match the IDs, Team ID, App Group, and distribution certificate. The workflow uses the profile names when Fastlane exports the archive.

## App Store Connect authentication (choose one)

### Recommended: API key

Set `APP_STORE_CONNECT_API_KEY_JSON` to a single JSON object containing the downloaded private key content:

```json
{"key_id":"ABC1234567","issuer_id":"00000000-0000-0000-0000-000000000000","key":"-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----"}
```

Keep the `.p8` private key secret. The key needs Developer or App Manager access. Do not commit the JSON or `.p8` file.

### Alternative: Apple ID application-specific password

Set `APP_STORE_CONNECT_USERNAME` to the App Store Connect Apple ID email and `APP_STORE_CONNECT_PASSWORD` to an Apple ID **app-specific password**. An ordinary Apple ID password is not suitable for CI. `APPLE_ID` may be set to the same email for scripts or future notarization steps. This method may require additional Apple authentication and is less reliable than an API key.

## Optional/recommended settings

- `APPLE_ID`: Apple ID email used for the developer account; normally the same value as `APP_STORE_CONNECT_USERNAME`.
- `FASTLANE_APPLE_APPLICATION_SPECIFIC_PASSWORD`: alternative Fastlane variable name for the app-specific password.
- `FASTLANE_SESSION`: optional Fastlane session if the account requires interactive authentication; sessions expire and should not be the primary CI method.
- `ITC_TEAM_ID`: App Store Connect provider/team ID only when the account has multiple providers.

## Creating base64 values

On macOS, run (without printing the result to logs):

```bash
base64 -i AppleDistribution.p12 | pbcopy
base64 -i DeyeCloudWidget.mobileprovision | pbcopy
```

Paste each clipboard value into the corresponding GitHub secret. On Windows PowerShell, use `[Convert]::ToBase64String([IO.File]::ReadAllBytes('file'))` and copy the output securely.

Rotate certificates, profiles, API keys, and passwords if they are exposed. Review Actions logs and make sure secret values are not echoed.
