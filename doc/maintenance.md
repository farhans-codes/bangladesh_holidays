# Maintaining the snapshot

1. Obtain the original annual MOPA PDF and national amendments. Visually read all
   pages: Bengali OCR alone is insufficient. Check date, category, lunar marks,
   community, district restrictions and any compensatory office-opening dates.
2. Edit the matching data/YYYY.json. Keep occurrence IDs stable when dates change;
   represent overlapping holidays separately. Include a source with publication
   date and HTTPS PDF URL. Add its hash and interpretation to sources.md.
3. Update verifiedOn only after reviewing the relevant sources. Do not silently
   turn a lunar-dependent date into a confirmed date merely because it has passed.
4. Run the generator and its --check mode. Regenerate instead of hand-editing
   lib/src/data/holidays.g.dart. The generator uses the Dart 3.4 formatting style
   for reproducible output.
5. Run analysis, `dart run tool/verify_package.dart`, the CLI example, publish
   dry-run and the manual checklist.
   Check same-day overlaps, supported-year edges and affected office rules.
6. Record the source/data change in CHANGELOG.md. Request owner approval before
   staging, committing, pushing, publishing or changing repository visibility.

No guessed future years. No global date shifts for an entire religious festival:
each affected occurrence needs the original notice and an explicit update.
Sector/constituency-specific declarations must not become nationwide closures.

## Localization

Edit both example/flutter/lib/l10n/app_en.arb and app_bn.arb together. Keep keys,
placeholder types and metadata consistent. Run flutter gen-l10n from the demo;
never edit generated localization Dart directly.

## Release preparation

- Follow [the release checklist](release-checklist.md) for current evidence and
  publication steps. Release tooling uses a current stable Dart SDK; the minimum
  consumer SDK is checked separately without the root development dependencies.
- Review git status, git diff and git diff --cached.
- Keep the owner's unrelated changes; never stage everything.
- After approved commits, rerun dart pub publish --dry-run from a clean checkout.
- Local dirty-worktree warnings are expected while approval is pending.
- Publication, pushing and making the repository public require explicit owner
  instructions; a successful dry-run does not publish anything.
