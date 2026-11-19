# Bangladesh Holidays mobile demo

Mobile-first Flutter example for the package in this repository.

```sh
flutter pub get
flutter gen-l10n
flutter run
```

Android is the primary platform. Use flutter run -d chrome for a secondary web
preview. Calendar, Calculate and Rules share one immutable office calendar.
The initial April 2027 range is an example. Rules are session-only.

Use the package's doc/manual-verification.md checklist. No Flutter test files
are included. Colors and text roles come from theme.dart; localizations come
from both ARB files. Generated localization files must not be edited by hand.
