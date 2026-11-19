# Manual verification

No Flutter test files are used. Run these scenarios whenever behavior, source
data or UI changes.

## Package scenarios

- Dhaka, Fri/Sat off, 12–18 April 2027 inclusive: four working dates (12, 13,
  15, 18), one public holiday (14) and two weekends (16, 17).
- Add three working days after 12 April: 18 April. Add negative two: 8 April.
  Zero on 14 April returns that same normalized date.
- 1 May 2026 and 20 May 2027 each preserve two official occurrences.
- 13 April closes Rangamati but not Dhaka by default. Selecting the Buddhist
  optional occurrence closes Dhaka; that selection is invalid in Rangamati.
- Optional dates are informational until selected. A community filter alone
  never closes dates.
- 23 May, 24 May and 17 October 2026 have explicit office-opening orders.
  Disable that policy to retain configured weekends. Another company holiday
  on an opening date must still close the office.
- Move/remove one occurrence, check originalDate and other same-day occurrences.
- Check national amendment dates: 11–12 February, 18 March, 25 May, 22 October
  and 7 November 2026.
- A range ending at 1 January 2028 may cover the last day of 2027. A request
  reaching an actual 2028 date must throw CoverageException. Check backward
  search beyond 2026 and next-holiday exhaustion as well.
- Reject reversed ranges, unknown/duplicate IDs, invalid weekdays, all seven
  weekdays off, and invalid optional selections. Verify copied inputs and
  immutable results.

## Mobile flows

1. Open Calendar. Check April 2027 starts on Thursday. Select 14 April and read
   Bangla New Year, its category and source. Navigate months and choose a date.
2. Calculate the initial range: four days. Scroll the daily breakdown to the end.
   In Rules remove Saturday from weekly days off, then recalculate: five days.
3. Switch to Add days. With Friday-only weekends, five days after 12 April is
   19 April. Try negative, zero, invalid text and a coverage-crossing amount.
4. Choose an end date before the start: show a recoverable range message.
5. Change district; select/unselect an approved optional holiday; browse a
   community without selecting dates; verify rules affect both tabs.
6. Add a company closure, dismiss the keyboard, reopen the list and delete it.
   An empty name must not save.
7. Move or ignore a holiday from its detail menu. Restore published dates from
   Rules. Reset office rules and verify the displayed district/weekends.
8. Switch English/Bangla while a result is visible. Inspect dates, result copy,
   dialogs, dropdowns, error messages and localized number formatting.
9. Inspect light/dark mode and font scale 1.3 on a phone. Scroll rather than clip.
   Check minimum 48dp controls, safe areas and native system Back.
10. On an 800dp-wide Android surface, verify the navigation rail and bounded
    content width. Verify date picker and theme changes remain usable.
11. Open an official source link on a device with a PDF-capable browser.

## Recorded verification — 19 November 2026

- Dart 3.13.5 / Flutter 3.47.7: generator --check, formatting and both analyzers
  passed. A scratch Dart run checked 41 package scenarios listed above.
- Android debug, ARM64 release APK and Flutter web builds succeeded. The release
  APK uses the example's development signing configuration, not store signing.
- Native Android emulator captures: ~393dp phone in English, Bangla at 1.3 font
  scale, dark mode, and 800dp tablet layout.
- UI actions verified: count=4, weekend change count=5, Friday-only add5=19 April,
  optional checkbox selection, company closure creation and deletion.
- After the review fixes, default Fri/Sat add5=20 April shows five working days
  across eight traversed dates, excluding the start. Changing the end date to
  19 April displays the actual range in both languages. Updated phone, large
  Bangla text, dark and tablet captures were inspected.
- In Add mode on the emulator, -2 after 12 April returns 8 April with four
  traversed dates in reverse order; zero returns 12 April with no traversed
  dates. Invalid numeric text shows a recoverable validation message. Bengali
  digit normalization was reviewed in code; Bengali keyboard entry remains
  part of the manual matrix.
- Remaining manual matrix includes external PDF launch, every dialog/error
  combination, TalkBack, physical-device gestures/performance and browser
  interaction. Those are not implied by successful builds.
- The web compiler reported a missing CupertinoIcons-font warning; no broken
  Android icons were observed. The native app uses Material icons.
- Repeat publish validation from the committed release before each upload.

## Package release checks — 19 November 2026

The package checks are now reproducible with `dart run tool/verify_package.dart`.
All 49 scenarios passed on Dart 3.13.5, on a separate minimum-SDK Dart 3.4.4
consumer, and after compilation to JavaScript under Node. The added cases cover
the smallest/largest integer counts, invalid months, weekend-versus-holiday
semantics, overlapping closure reasons and immutable policy/coverage objects.
No Flutter test files were added or changed. See [release readiness](release-checklist.md)
for publication-specific checks.
