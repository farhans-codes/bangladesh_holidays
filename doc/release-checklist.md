# Release checklist

## Validate a release

1. Review the official source ledger and any new amendments. Keep coverage and
   uncertainty metadata honest; never extrapolate an unsupported year.
2. Update the version and changelog. Check public API documentation and examples.
3. Run the commands below from the package root with a current stable Dart SDK.
   Also run the verification script as a consumer on the minimum supported SDK.
4. Review the exact files included by the publish dry-run. The Flutter demo,
   generated builds and local design notes must stay outside the package archive.
5. Commit the reviewed release, push it and confirm CI passes. Verify that
   repository, issue tracker and README links are publicly accessible.
6. Authenticate to pub.dev using the intended owner account. Confirm the account
   identity before publishing, especially when switching between accounts.
7. Publish the committed release, then check the version, API documentation and
   a fresh consumer installation on pub.dev.

```sh
dart pub get
dart run tool/generate_data.dart --check
dart format --output=none --set-exit-if-changed lib tool example/bangladesh_holidays_example.dart
dart analyze --fatal-infos
dart run tool/verify_package.dart
dart run example/bangladesh_holidays_example.dart
dart pub outdated
dart pub publish --dry-run
```

After the release is approved and the final dry-run is clean:

```sh
dart pub login
dart pub publish
```

No automatic publishing workflow is configured. Pushing code does not publish
the package. Changes after publication require a new version.

## v0.1.0 local verification

Checked on **19 November 2026**:

- 126 holiday occurrences for 2026/2027; source validation and generation passed.
- 49 package scenarios passed on Dart 3.13.5, a Dart 3.4.4 consumer and compiled
  JavaScript under Node.
- Formatting, static analysis and dependency checks passed.
- API reference generation with link validation: zero warnings and errors.
- Local pana 0.23.19: 160/160, with 87/87 documented API elements. A local result
  does not guarantee the hosted score; pub.dev performs its own analysis.
- No runtime dependencies. The Flutter application is a separate repository
  example, excluded from the published archive.

See [manual verification](manual-verification.md) for covered scenarios and
remaining device-specific checks.

Official references: [Dart publishing guide](https://dart.dev/tools/pub/publishing)
and [pub.dev scoring guide](https://pub.dev/help/scoring).
