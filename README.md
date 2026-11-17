# bangladesh_holidays — পরিকল্পনা

> এই repo-তে এখনো কোনো code নেই। এটা package বানানোর পরিকল্পনা।
> পরিকল্পনার তারিখ: ১৭ নভেম্বর ২০২৬

বাংলাদেশের সরকারি ছুটির তালিকা আর কাজের দিনের হিসাবের জন্য একটা pure Dart package, যেটা Flutter আর Dart server দুই জায়গাতেই চলবে, internet ছাড়াই।

## কেন

যাচাই করে দেখা গেছে (নভেম্বর ২০২৬):

| কোথায় | অবস্থা |
|---|---|
| pub.dev | বাংলাদেশের ছুটির কোনো package নেই। `world_holidays` মাত্র ১০টা দেশ ধরে, বাংলাদেশ নেই। `country_holiday` Google Calendar-এর উপর নির্ভরশীল, internet লাগে। |
| JavaScript | [`bangladesh-holidays`](https://github.com/shamsad-alam-meraj/bangladesh-holidays) — ৬ নভেম্বর ২০২৬-এ বেরিয়েছে, খুব পূর্ণাঙ্গ। **কী কী feature লাগে তার ভালো উদাহরণ।** |
| Python | `holidays` library-তে বাংলাদেশ আছে, চাঁদ-নির্ভর ছুটি "আনুমানিক" হিসেবে। |
| Nager.Date API | বাংলাদেশ আছে, কিন্তু ২০২৬-এ মাত্র ৭টা ছুটি, ঈদ বা পূজা নেই। |

অর্থাৎ চাহিদা আছে (অন্য ভাষায় বানানো হচ্ছে), কিন্তু Flutter/Dart developer-দের জন্য কিছু নেই।

**নাম:** `bangladesh_holidays` — pub.dev-এ খালি আছে (১৭ নভেম্বর ২০২৬ পর্যন্ত)। বিকল্প: `bd_holidays`।

## কারা ব্যবহার করবে

HR আর বেতনের app, স্কুল-অফিসের app, delivery আর courier-এর সময় হিসাব, ব্যাংকিং ও fintech, calendar app, আর যেকোনো app যেখানে "পরের কাজের দিন কবে" জানা দরকার।

## ডেটা

### উৎস

- **সরকারি ছুটি:** জনপ্রশাসন মন্ত্রণালয়ের (MoPA, mopa.gov.bd) বার্ষিক প্রজ্ঞাপন। সাধারণত বছরের শেষে পরের বছরের তালিকা আসে। JavaScript package-এর তথ্য অনুযায়ী ২০২৭-এর তালিকা ৫ নভেম্বর ২০২৬-এ প্রকাশ হয়েছে। নিজে PDF খুলে যাচাই করতে হবে।
- **ব্যাংক ছুটি:** Bangladesh Bank আলাদা তালিকা দেয়, সরকারি তালিকা থেকে আলাদা হতে পারে। প্রথম version-এ না রাখলেও চলে।
- **শিক্ষা প্রতিষ্ঠানের ছুটি:** আলাদা, এই package-এর বাইরে।

**নিয়ম:** ডেটা সবসময় সরাসরি সরকারি প্রজ্ঞাপন থেকে নেব। অন্য package বা library-র ডেটা copy করব না; ওগুলো শুধু মিলিয়ে দেখার জন্য।

### সরকারি তালিকার ছুটির ধরন

- **সাধারণ ছুটি** — সবার জন্য।
- **নির্বাহী আদেশে ছুটি** — সরকারি সিদ্ধান্তে, সাধারণত ঈদের মতো ছুটির আগে-পরে।
- **ঐচ্ছিক ছুটি** — ধর্ম অনুযায়ী (মুসলিম, হিন্দু, খ্রিস্টান, বৌদ্ধ, ক্ষুদ্র নৃ-গোষ্ঠী), কর্মী বছরে নির্দিষ্ট কয়েকদিন নিতে পারে।
- **আঞ্চলিক ছুটি** — যেমন চৈত্র সংক্রান্তি শুধু তিন পার্বত্য জেলায়।
- **সাপ্তাহিক ছুটি** — শুক্র ও শনিবার।

### ডেটার গঠন (প্রতিটা ছুটি)

| ঘর | উদাহরণ |
|---|---|
| `date` | 2027-03-26 |
| `nameEn` / `nameBn` | Independence Day / স্বাধীনতা ও জাতীয় দিবস |
| `type` | general / executiveOrder / optional / regional |
| `religion` | ঐচ্ছিক ছুটির জন্য: islam / hinduism / christianity / buddhism / ethnic |
| `regions` | আঞ্চলিক ছুটির জন্য জেলার তালিকা |
| `isEstimated` | চাঁদ দেখার উপর নির্ভরশীল কিনা |
| `source` | কোন প্রজ্ঞাপন থেকে নেওয়া |

### সংরক্ষণ

- প্রতি বছরের জন্য একটা JSON file (`data/2026.json`, `data/2027.json`) — মানুষ পড়তে আর সংশোধন করতে পারবে।
- একটা ছোট script সেই JSON থেকে Dart code বানাবে, যাতে package চালাতে কোনো file পড়া বা internet লাগে না, আর Flutter ছাড়া খাঁটি Dart-এও চলে।

## API-এর নকশা (প্রাথমিক)

```dart
final bd = BangladeshHolidays();

// ছুটি কিনা
bd.isHoliday(DateTime(2027, 3, 26));            // true
bd.holidayOn(DateTime(2027, 3, 26))?.nameBn;     // স্বাধীনতা ও জাতীয় দিবস

// তালিকা
bd.holidaysIn(2027);                             // পুরো বছর
bd.holidaysBetween(start, end);
bd.nextHoliday(from: DateTime.now());

// কাজের দিন (শুক্র-শনি আর ছুটি বাদ দিয়ে)
bd.isBusinessDay(date);
bd.addBusinessDays(date, 5);
bd.businessDaysBetween(start, end);

// কোন বছরের ডেটা আছে
bd.isCovered(2028);                              // false হলে ভুল উত্তর না দিয়ে জানিয়ে দেবে

// নিয়ন্ত্রণ
BangladeshHolidays(
  include: {HolidayType.general, HolidayType.executiveOrder},
  religion: Religion.hinduism,                   // কোন ঐচ্ছিক ছুটি ধরবে
  district: 'Rangamati',                         // আঞ্চলিক ছুটি
  overrides: [...],                              // app নিজে তারিখ ঠিক করবে (যেমন চাঁদ দেখার পর)
  extraHolidays: [...],                          // কোম্পানির নিজস্ব ছুটি
);
```

**গুরুত্বপূর্ণ নীতি:** যে বছরের ডেটা নেই, সেখানে package অনুমান করে ভুল উত্তর দেবে না, স্পষ্ট জানিয়ে দেবে।

## চাঁদ-নির্ভর ছুটি (ঈদ, শবে বরাত, শবে কদর ইত্যাদি)

- সরকারি তালিকায় এগুলোর তারিখ আগে থেকে দেওয়া থাকে, কিন্তু চাঁদ দেখার পর বদলাতে পারে।
- এগুলোতে `isEstimated: true` থাকবে।
- app চাইলে `overrides` দিয়ে নিজে তারিখ ঠিক করতে পারবে, package আপডেটের অপেক্ষা না করেই।
- সরকার তারিখ নিশ্চিত করলে package-এর patch আপডেট।

## বছরে একবারের আপডেট (যত সহজ করা যায়)

1. **মনে করিয়ে দেওয়া:** GitHub Actions প্রতি বছর ১ নভেম্বর নিজে থেকে একটা issue খুলবে — "২০XX-এর ছুটি যোগ করো"।
2. **যোগ করা:** MoPA-র প্রজ্ঞাপন দেখে নতুন বছরের JSON file লেখা (আধা ঘণ্টা থেকে এক ঘণ্টা)।
3. **যাচাই:** script Dart code বানাবে, test চলবে (তারিখ ঠিক আছে কিনা, একই দিনে দুটো ছুটি থাকলে ঠিকঠাক কিনা)।
4. **প্রকাশ:** নতুন minor version (যেমন 1.2.0) pub.dev-এ।

অন্যরাও JSON file সংশোধন করে Pull Request দিতে পারবে, তাই সব কাজ একা করতে হবে না।

## ধাপে ধাপে পরিকল্পনা

### v0.1 — মূল অংশ
- [ ] MoPA থেকে ২০২৬ আর ২০২৭-এর প্রজ্ঞাপন সংগ্রহ ও JSON-এ রূপান্তর
- [ ] ডেটার গঠন (Holiday, HolidayType, Religion)
- [ ] `isHoliday`, `holidayOn`, `holidaysIn`, `holidaysBetween`, `nextHoliday`, `isCovered`
- [ ] JSON থেকে Dart code বানানোর script
- [ ] Test

### v0.2 — কাজের দিন
- [ ] `isBusinessDay`, `addBusinessDays`, `businessDaysBetween`
- [ ] শুক্র-শনি সাপ্তাহিক ছুটি, ঈদের লম্বা ছুটির test

### v0.3 — নিয়ন্ত্রণ আর বাংলা
- [ ] ঐচ্ছিক (ধর্ম অনুযায়ী) আর আঞ্চলিক ছুটি
- [ ] `overrides` আর `extraHolidays`
- [ ] বাংলা নাম আর বাংলা সংখ্যায় তারিখ

### v1.0 — প্রকাশ
- [ ] পূর্ণ README (ইংরেজিতে), API documentation
- [ ] Flutter example app (ছুটির calendar দেখানো)
- [ ] বার্ষিক reminder-এর GitHub Action
- [ ] pub.dev score ১৬০/১৬০
- [ ] repo public করা, pub.dev-এ publish

### পরে (প্রয়োজন হলে)
- [ ] Bangladesh Bank-এর ব্যাংক ছুটি
- [ ] iCalendar (.ics) export
- [ ] ২০২৫ বা তার আগের বছরের ডেটা

## ঝুঁকি আর সাবধানতা

- **নির্ভুলতা:** ভুল তারিখ মানে কারো বেতন বা delivery-র হিসাব ভুল। প্রতিটা তারিখের উৎস রাখতে হবে, আর README-তে স্পষ্ট disclaimer: "সরকারি প্রজ্ঞাপনই চূড়ান্ত"।
- **সরকারি পরিবর্তন:** ২০২৫-এর মতো হঠাৎ ছুটি যোগ বা বাতিল হলে বছরের মাঝখানেও আপডেট লাগবে।
- **প্রতিযোগিতা:** JavaScript package-এর মালিক Dart version বানাতে পারেন। তাড়াতাড়ি v0.1 বের করা ভালো।

## Portfolio-তে যা দেখাবে

- Dart package design আর pub.dev-এ publish করা (score, like, download সংখ্যা মাপা যায়)
- বাস্তব সরকারি ডেটা নিয়ে কাজ, নির্ভুলতা আর রক্ষণাবেক্ষণের ব্যবস্থা
- GitHub Actions দিয়ে স্বয়ংক্রিয় test আর বার্ষিক reminder

## খোলা প্রশ্ন

- [ ] নাম চূড়ান্ত: `bangladesh_holidays` নাকি `bd_holidays`?
- [ ] প্রথম version-এ ঐচ্ছিক ছুটি রাখব নাকি পরে?
- [ ] বঙ্গাব্দ তারিখ এই package-এ রাখব, নাকি `bangla_utilities`-এর মতো বিদ্যমান package-এর উপর ছেড়ে দেব?
