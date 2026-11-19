import 'dart:math' as math;

import 'package:bangladesh_holidays/bangladesh_holidays.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'l10n/app_localizations.dart';
import 'labels.dart';
import 'theme.dart';

class HolidayHome extends StatefulWidget {
  const HolidayHome({
    super.key,
    required this.onLanguage,
    required this.themeMode,
    required this.onTheme,
  });
  final VoidCallback onLanguage;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onTheme;

  @override
  State<HolidayHome> createState() => _HolidayHomeState();
}

class _HolidayHomeState extends State<HolidayHome> {
  int _tab = 0;
  DateTime _selected = DateTime.utc(2027, 4, 14);
  DateTime _month = DateTime.utc(2027, 4);
  DateTime _from = DateTime.utc(2027, 4, 12);
  DateTime _through = DateTime.utc(2027, 4, 18);
  District? _district = District.dhaka;
  final _weekends = <int>{DateTime.friday, DateTime.saturday};
  final _types = <HolidayType>{HolidayType.general, HolidayType.executiveOrder};
  final _optionalIds = <String>{};
  final _extra = <Holiday>[];
  final _overrides = <String, HolidayOverride>{};
  bool _officialWorking = true;
  bool _addMode = false;
  int _ruleYear = 2027;
  HolidayCommunity? _community;
  int _companyCounter = 0;
  late BangladeshHolidays _calendar = _makeCalendar();
  final _amount = TextEditingController(text: '5');
  List<DayStatus>? _result;
  DateTime? _resultDate;
  String? _errorKey;

  AppLocalizations get l => AppLocalizations.of(context);
  ColorScheme get colors => Theme.of(context).colorScheme;
  TextTheme get type => Theme.of(context).textTheme;
  DayColors get dayColors => Theme.of(context).extension<DayColors>()!;
  bool get bangla => Localizations.localeOf(context).languageCode == 'bn';
  String dateLabel(DateTime date, [String pattern = 'd MMM y']) =>
      DateFormat(pattern, bangla ? 'bn' : 'en').format(date);
  String holidayName(Holiday value) => bangla ? value.nameBn : value.nameEn;
  String number(int value) =>
      NumberFormat.decimalPattern(bangla ? 'bn' : 'en').format(value);

  BangladeshHolidays _makeCalendar() => BangladeshHolidays(
    district: _district,
    weekendDays: _weekends,
    include: _types,
    selectedOptionalHolidayIds: _optionalIds,
    extraHolidays: _extra,
    overrides: _overrides.values,
    applyGovernmentWorkingDays: _officialWorking,
  );

  void _changeRules(VoidCallback change) => setState(() {
    change();
    final catalog = BangladeshHolidays(overrides: _overrides.values);
    final available = catalog.holidaysBetween(
      DateTime.utc(2026),
      DateTime.utc(2028),
    );
    _optionalIds.removeWhere(
      (id) => !available.any((h) => h.id == id && h.appliesTo(_district)),
    );
    _calendar = _makeCalendar();
    _clearResult();
  });

  void _clearResult() {
    _result = null;
    _resultDate = null;
    _errorKey = null;
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<DateTime?> _pickDate(DateTime initial) async {
    final value = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2026),
      lastDate: DateTime(2027, 12, 31),
    );
    return value == null
        ? null
        : DateTime.utc(value.year, value.month, value.day);
  }

  void _message(String text) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));

  Future<void> _openSource(HolidaySource source) async {
    try {
      final opened = await launchUrl(
        Uri.parse(source.url),
        mode: LaunchMode.externalApplication,
      );
      if (!opened && mounted) _message(l.sourceUnavailable);
    } catch (_) {
      if (mounted) _message(l.sourceUnavailable);
    }
  }

  String get _rulesSummary {
    final days = _weekends.toList()..sort();
    return '${l.districtName(_district)} · ${days.isEmpty ? l.none : days.map(l.weekday).join(', ')}';
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final expanded = constraints.maxWidth >= Space.railBreakpoint;
      final destinations = [
        NavigationDestination(
          icon: const Icon(Icons.calendar_month_outlined),
          selectedIcon: const Icon(Icons.calendar_month),
          label: l.calendar,
        ),
        NavigationDestination(
          icon: const Icon(Icons.calculate_outlined),
          selectedIcon: const Icon(Icons.calculate),
          label: l.calculateTab,
        ),
        NavigationDestination(icon: const Icon(Icons.tune), label: l.rules),
      ];
      return Scaffold(
        appBar: AppBar(
          title: Text(l.appTitle, maxLines: 2),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: colors.onPrimary),
              onPressed: widget.onLanguage,
              child: Tooltip(
                message: l.switchLanguage,
                child: Text(l.language),
              ),
            ),
            const SizedBox(width: Space.small),
          ],
        ),
        bottomNavigationBar: expanded
            ? null
            : NavigationBar(
                selectedIndex: _tab,
                onDestinationSelected: (value) => setState(() => _tab = value),
                destinations: destinations,
              ),
        body: SafeArea(
          top: false,
          child: Row(
            children: [
              if (expanded)
                NavigationRail(
                  selectedIndex: _tab,
                  onDestinationSelected: (value) =>
                      setState(() => _tab = value),
                  labelType: NavigationRailLabelType.all,
                  destinations: destinations
                      .map(
                        (d) => NavigationRailDestination(
                          icon: d.icon,
                          selectedIcon: d.selectedIcon,
                          label: Text(d.label),
                        ),
                      )
                      .toList(),
                ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: Space.contentWidth,
                    ),
                    child: SingleChildScrollView(
                      key: PageStorageKey(_tab),
                      padding: const EdgeInsets.all(Space.page),
                      child: switch (_tab) {
                        0 => _calendarPage(),
                        1 => _calculatorPage(),
                        _ => _rulesPage(),
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  Widget _calendarPage() {
    final monthEnd = DateTime.utc(_month.year, _month.month + 1, 0).day;
    final offset = _month.weekday % 7;
    final rows = ((offset + monthEnd) / 7).ceil();
    final detail = _calendar.dayStatus(_selected);
    final holidays = _calendar
        .holidaysOn(_selected)
        .where((h) => h.appliesTo(_district))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: ActionChip(
            avatar: const Icon(Icons.business_outlined),
            label: Text(_rulesSummary),
            tooltip: l.editRules,
            onPressed: () => setState(() => _tab = 2),
          ),
        ),
        const SizedBox(height: Space.small),
        Row(
          children: [
            IconButton(
              tooltip: l.previousMonth,
              onPressed: _month == DateTime.utc(2026)
                  ? null
                  : () => setState(() {
                      _month = DateTime.utc(_month.year, _month.month - 1);
                      _selected = _month;
                    }),
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: TextButton(
                onPressed: () async {
                  final date = await _pickDate(_selected);
                  if (date != null && mounted) {
                    setState(() {
                      _selected = date;
                      _month = DateTime.utc(date.year, date.month);
                    });
                  }
                },
                child: Text(
                  dateLabel(_month, 'MMMM y'),
                  style: type.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            IconButton(
              tooltip: l.nextMonth,
              onPressed: _month == DateTime.utc(2027, 12)
                  ? null
                  : () => setState(() {
                      _month = DateTime.utc(_month.year, _month.month + 1);
                      _selected = _month;
                    }),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: Space.small),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = math.max(
              constraints.maxWidth,
              Space.calendarMinWidth,
            );
            final scale = MediaQuery.textScalerOf(context).scale(1);
            final cellHeight = Space.touch * math.max(1.0, scale);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Material(
                color: colors.surface,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(Space.radius),
                child: SizedBox(
                  width: width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          for (final day in [7, 1, 2, 3, 4, 5, 6])
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: Space.small,
                                ),
                                child: Text(
                                  l.weekdayCompact(day),
                                  textAlign: TextAlign.center,
                                  style: type.labelMedium,
                                ),
                              ),
                            ),
                        ],
                      ),
                      for (var row = 0; row < rows; row++)
                        Row(
                          children: [
                            for (var column = 0; column < 7; column++)
                              Expanded(
                                child: SizedBox(
                                  height: cellHeight,
                                  child: _dateCell(
                                    row * 7 + column - offset + 1,
                                    monthEnd,
                                  ),
                                ),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: Space.medium),
        Wrap(
          spacing: Space.page,
          runSpacing: Space.small,
          children: [
            _legend(
              l.workingDay,
              Icons.check_circle_outline,
              dayColors.working,
            ),
            _legend(l.holiday, Icons.event_busy_outlined, dayColors.holiday),
            _legend(l.selectedRange, Icons.date_range, colors.primary),
          ],
        ),
        const SizedBox(height: Space.section),
        Text(dateLabel(_selected, 'EEEE, d MMMM'), style: type.titleLarge),
        const SizedBox(height: Space.small),
        if (holidays.isEmpty)
          Text(
            detail.isBusinessDay ? l.noHoliday : l.weekend,
            style: type.bodyLarge,
          ),
        for (final h in holidays)
          Padding(
            padding: const EdgeInsets.only(bottom: Space.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  holidayName(h),
                  style: type.titleLarge?.copyWith(
                    color: detail.holidays.any((item) => item.id == h.id)
                        ? dayColors.holiday
                        : colors.onSurface,
                  ),
                ),
                const SizedBox(height: Space.tight),
                Text(
                  h.type == HolidayType.optional && !_optionalIds.contains(h.id)
                      ? l.unselectedOptional
                      : l.typeName(h.type),
                  style: type.bodyMedium,
                ),
                if (h.isEstimated)
                  Text(
                    l.estimated,
                    style: type.bodyMedium?.copyWith(color: dayColors.holiday),
                  ),
                if (h.isDateOverridden)
                  Text(l.customDate, style: type.bodyMedium),
                if ((bangla ? h.notesBn : h.notesEn).isNotEmpty)
                  Text(bangla ? h.notesBn : h.notesEn, style: type.bodyMedium),
                if (h.source != null)
                  Wrap(
                    spacing: Space.small,
                    children: [
                      TextButton.icon(
                        onPressed: () => _openSource(h.source!),
                        icon: const Icon(Icons.open_in_new),
                        label: Text(l.viewSource),
                      ),
                      PopupMenuButton<String>(
                        tooltip: l.overridesTitle,
                        onSelected: (value) => _overrideHoliday(h, value),
                        itemBuilder: (_) => [
                          PopupMenuItem(value: 'move', child: Text(l.moveDate)),
                          PopupMenuItem(
                            value: 'remove',
                            child: Text(l.removeHoliday),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        if (detail.governmentWorkingDay != null)
          Text(l.officeOpen, style: type.bodyMedium),
        const SizedBox(height: Space.medium),
        FilledButton.icon(
          onPressed: () => setState(() => _tab = 1),
          icon: const Icon(Icons.calculate_outlined),
          label: Text(l.calculateAction),
        ),
        const SizedBox(height: Space.medium),
        Text(
          _from == DateTime.utc(2027, 4, 12) &&
                  _through == DateTime.utc(2027, 4, 18)
              ? l.sample
              : l.rangeSelection(dateLabel(_from), dateLabel(_through)),
          style: type.bodySmall,
        ),
      ],
    );
  }

  Widget _dateCell(int day, int last) {
    if (day < 1 || day > last) return const SizedBox.shrink();
    final date = DateTime.utc(_month.year, _month.month, day);
    final status = _calendar.dayStatus(date);
    final selected = date == _selected;
    final inRange = !date.isBefore(_from) && !date.isAfter(_through);
    final hasHoliday = status.holidays.isNotEmpty;
    final foreground = selected
        ? (hasHoliday ? colors.surface : colors.onPrimary)
        : hasHoliday
        ? dayColors.holiday
        : (inRange && status.isBusinessDay
              ? dayColors.working
              : colors.onSurface);
    final background = inRange ? colors.secondaryContainer : colors.surface;
    final markerSize =
        Space.touch * math.max(1.0, MediaQuery.textScalerOf(context).scale(1)) -
        Space.small;
    return Semantics(
      label:
          '${dateLabel(date, 'EEEE, d MMMM y')}, ${status.isBusinessDay
              ? l.workingDay
              : hasHoliday
              ? status.holidays.map(holidayName).join(', ')
              : l.weekend}',
      selected: selected,
      button: true,
      excludeSemantics: true,
      child: Material(
        color: background,
        child: InkWell(
          onTap: () => setState(() => _selected = date),
          child: Center(
            child: Container(
              width: markerSize,
              height: markerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected
                    ? (hasHoliday ? dayColors.holiday : colors.primary)
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    number(day),
                    style: type.titleMedium?.copyWith(
                      color: foreground,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                    ),
                  ),
                  if (hasHoliday && !selected)
                    Icon(Icons.circle, size: Space.tight, color: foreground),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _legend(String text, IconData icon, Color color) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: Space.page, color: color),
      const SizedBox(width: Space.tight),
      Text(text, style: type.labelMedium),
    ],
  );

  Widget _dateButton(
    String label,
    DateTime value,
    ValueChanged<DateTime> onChanged,
  ) => OutlinedButton(
    onPressed: () async {
      final date = await _pickDate(value);
      if (date != null && mounted) onChanged(date);
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: Space.medium),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: type.labelMedium),
                Text(dateLabel(value), style: type.titleMedium),
              ],
            ),
          ),
          const Icon(Icons.calendar_today_outlined),
        ],
      ),
    ),
  );

  Widget _calculatorPage() => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(_addMode ? l.addDays : l.countTitle, style: type.headlineSmall),
      const SizedBox(height: Space.page),
      SegmentedButton<bool>(
        segments: [
          ButtonSegment(value: false, label: Text(l.countDays)),
          ButtonSegment(value: true, label: Text(l.addDays)),
        ],
        selected: {_addMode},
        onSelectionChanged: (v) => setState(() {
          _addMode = v.single;
          _clearResult();
        }),
      ),
      const SizedBox(height: Space.page),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(_rulesSummary, style: type.titleMedium),
        trailing: IconButton(
          tooltip: l.editRules,
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => setState(() => _tab = 2),
        ),
      ),
      _dateButton(
        l.from,
        _from,
        (d) => setState(() {
          _from = d;
          _clearResult();
        }),
      ),
      const SizedBox(height: Space.medium),
      if (!_addMode)
        _dateButton(
          l.through,
          _through,
          (d) => setState(() {
            _through = d;
            _clearResult();
          }),
        )
      else
        TextField(
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          onChanged: (_) => setState(_clearResult),
          decoration: InputDecoration(
            labelText: l.amount,
            helperText: l.amountHint,
            helperMaxLines: 3,
          ),
        ),
      const SizedBox(height: Space.small),
      Text(_addMode ? l.addHint : l.inclusiveHint, style: type.bodySmall),
      const SizedBox(height: Space.page),
      FilledButton(onPressed: _calculate, child: Text(l.calculate)),
      const SizedBox(height: Space.section),
      if (_errorKey != null)
        Semantics(
          liveRegion: true,
          child: Text(switch (_errorKey) {
            'range' => l.invalidRange,
            'amount' => l.invalidAmount,
            _ => l.coverageError,
          }, style: type.bodyLarge?.copyWith(color: colors.error)),
        ),
      if (_resultDate != null)
        Semantics(
          liveRegion: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.resultDate, style: type.bodyLarge),
              Text(
                dateLabel(_resultDate!, 'EEEE, d MMMM y'),
                style: type.headlineSmall?.copyWith(color: dayColors.working),
              ),
            ],
          ),
        ),
      if (_result != null) ...[
        Semantics(
          liveRegion: true,
          child: Text(
            l.daysResult(_result!.where((d) => d.isBusinessDay).length),
            style: (_addMode ? type.titleMedium : type.headlineSmall)?.copyWith(
              color: dayColors.working,
            ),
          ),
        ),
        const SizedBox(height: Space.tight),
        Text(
          _addMode
              ? l.traversedDays(_result!.length)
              : l.rangeResult(_result!.length),
          style: type.bodyLarge,
        ),
        if (_result!.any((day) => day.hasEstimatedHoliday))
          Padding(
            padding: const EdgeInsets.only(top: Space.small),
            child: Text(
              l.uncertainResult,
              style: type.bodyMedium?.copyWith(color: dayColors.holiday),
            ),
          ),
        const SizedBox(height: Space.section),
        Text(l.breakdown, style: type.titleMedium),
        const SizedBox(height: Space.small),
        for (final day in _result!) _dayRow(day),
      ],
      if (_result == null && _resultDate == null && _errorKey == null)
        Text(l.pendingResult, style: type.bodyLarge),
    ],
  );

  void _calculate() => setState(() {
    _clearResult();
    try {
      if (_addMode) {
        final normalized = _amount.text.trim().replaceAllMapped(
          RegExp('[০-৯]'),
          (match) => (match[0]!.runes.single - 0x09e6).toString(),
        );
        final value = int.tryParse(normalized);
        if (value == null || value.abs() > 730) {
          _errorKey = 'amount';
          return;
        }
        _resultDate = _calendar.addBusinessDays(_from, value);
        _result = value == 0
            ? []
            : value > 0
            ? _calendar.daysBetween(
                _from.add(const Duration(days: 1)),
                _resultDate!.add(const Duration(days: 1)),
              )
            : _calendar.daysBetween(_resultDate!, _from).reversed.toList();
      } else {
        if (_through.isBefore(_from)) {
          _errorKey = 'range';
          return;
        }
        _result = _calendar.daysBetween(
          _from,
          _through.add(const Duration(days: 1)),
        );
      }
    } on CoverageException {
      _errorKey = 'coverage';
    }
  });

  Widget _dayRow(DayStatus day) {
    final working = day.isBusinessDay;
    final holiday = day.holidays.isNotEmpty;
    final fg = working
        ? dayColors.working
        : holiday
        ? dayColors.holiday
        : colors.primary;
    final bg = working
        ? dayColors.workingSurface
        : holiday
        ? dayColors.holidaySurface
        : colors.secondaryContainer;
    final reasons = [
      if (day.reasons.contains(NonWorkingReason.weekend)) l.weekend,
      ...day.holidays.map(holidayName),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Space.tight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Space.touch + Space.page,
            padding: const EdgeInsets.symmetric(vertical: Space.small),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(Space.cellRadius),
            ),
            child: Column(
              children: [
                Text(
                  dateLabel(day.date, 'EEE'),
                  style: type.labelMedium?.copyWith(color: fg),
                ),
                Text(
                  number(day.date.day),
                  style: type.titleLarge?.copyWith(color: fg),
                ),
                Text(
                  dateLabel(day.date, 'MMM'),
                  style: type.labelSmall?.copyWith(color: fg),
                ),
              ],
            ),
          ),
          const SizedBox(width: Space.medium),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Space.small),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    working ? l.counted : reasons.join(' · '),
                    style: type.titleMedium?.copyWith(color: fg),
                  ),
                  Text(
                    working
                        ? (day.governmentWorkingDay != null
                              ? l.officeOpen
                              : l.workingDay)
                        : l.excluded,
                    style: type.bodyMedium,
                  ),
                  if (day.hasEstimatedHoliday)
                    Text(l.estimated, style: type.bodySmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rulesPage() {
    final optional = _calendar
        .holidaysIn(
          _ruleYear,
          types: {HolidayType.optional},
          community: _community,
        )
        .where((h) => h.appliesTo(_district))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.rules, style: type.headlineSmall),
        const SizedBox(height: Space.small),
        Text(l.rulesIntro, style: type.bodyLarge),
        const SizedBox(height: Space.section),
        DropdownButtonFormField<String>(
          initialValue: _district?.name ?? 'nationwide',
          isExpanded: true,
          decoration: InputDecoration(labelText: l.district),
          items: [
            DropdownMenuItem(value: 'nationwide', child: Text(l.nationwide)),
            for (final district in District.values)
              DropdownMenuItem(
                value: district.name,
                child: Text(l.districtName(district)),
              ),
          ],
          onChanged: (value) => _changeRules(() {
            _district = value == 'nationwide'
                ? null
                : District.values.byName(value!);
          }),
        ),
        const SizedBox(height: Space.section),
        Text(l.weekends, style: type.titleMedium),
        const SizedBox(height: Space.small),
        Wrap(
          spacing: Space.small,
          children: [
            for (var day = 1; day <= 7; day++)
              FilterChip(
                label: Text(l.weekday(day)),
                selected: _weekends.contains(day),
                onSelected: (selected) {
                  if (selected && _weekends.length == 6) {
                    _message(l.weekendError);
                    return;
                  }
                  _changeRules(
                    () => selected ? _weekends.add(day) : _weekends.remove(day),
                  );
                },
              ),
          ],
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l.followGeneral),
          value: _types.contains(HolidayType.general),
          onChanged: (value) => _changeRules(
            () => value
                ? _types.add(HolidayType.general)
                : _types.remove(HolidayType.general),
          ),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l.followExecutive),
          value: _types.contains(HolidayType.executiveOrder),
          onChanged: (value) => _changeRules(
            () => value
                ? _types.add(HolidayType.executiveOrder)
                : _types.remove(HolidayType.executiveOrder),
          ),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l.followWorking),
          subtitle: Text(l.followWorkingHint),
          value: _officialWorking,
          onChanged: (value) => _changeRules(() => _officialWorking = value),
        ),
        const SizedBox(height: Space.section),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Text(l.optionalTitle),
          children: [
            Text(l.optionalHint, style: type.bodyMedium),
            const SizedBox(height: Space.medium),
            DropdownButtonFormField<int>(
              initialValue: _ruleYear,
              decoration: InputDecoration(labelText: l.year),
              items: [
                for (final year in _calendar.supportedYears)
                  DropdownMenuItem(value: year, child: Text(number(year))),
              ],
              onChanged: (value) => setState(() => _ruleYear = value!),
            ),
            const SizedBox(height: Space.medium),
            DropdownButtonFormField<String>(
              initialValue: _community?.name ?? 'all',
              isExpanded: true,
              decoration: InputDecoration(labelText: l.communityFilter),
              items: [
                DropdownMenuItem(value: 'all', child: Text(l.allCommunities)),
                for (final group in HolidayCommunity.values)
                  DropdownMenuItem(
                    value: group.name,
                    child: Text(l.communityName(group)),
                  ),
              ],
              onChanged: (value) => setState(
                () => _community = value == 'all'
                    ? null
                    : HolidayCommunity.values.byName(value!),
              ),
            ),
            const SizedBox(height: Space.small),
            for (final holiday in optional)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(holidayName(holiday)),
                subtitle: Text(dateLabel(holiday.date)),
                value: _optionalIds.contains(holiday.id),
                onChanged: (selected) => _changeRules(
                  () => selected!
                      ? _optionalIds.add(holiday.id)
                      : _optionalIds.remove(holiday.id),
                ),
              ),
          ],
        ),
        const SizedBox(height: Space.section),
        Text(l.companyTitle, style: type.titleLarge),
        const SizedBox(height: Space.small),
        if (_extra.isEmpty) Text(l.noCompany, style: type.bodyMedium),
        for (final h in _extra)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(holidayName(h)),
            subtitle: Text(dateLabel(h.date)),
            trailing: IconButton(
              tooltip: l.remove,
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _changeRules(() => _extra.remove(h)),
            ),
          ),
        const SizedBox(height: Space.small),
        OutlinedButton.icon(
          onPressed: _addCompany,
          icon: const Icon(Icons.add),
          label: Text(l.addCompany),
        ),
        const SizedBox(height: Space.section),
        Text(l.overridesTitle, style: type.titleLarge),
        const SizedBox(height: Space.small),
        Text(l.overridesHint, style: type.bodyMedium),
        Text(l.overrideCount(_overrides.length), style: type.bodyMedium),
        if (_overrides.isNotEmpty)
          TextButton(
            onPressed: () => _changeRules(_overrides.clear),
            child: Text(l.restore),
          ),
        const SizedBox(height: Space.section),
        DropdownButtonFormField<ThemeMode>(
          initialValue: widget.themeMode,
          decoration: InputDecoration(labelText: l.appearance),
          items: [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text(l.systemTheme),
            ),
            DropdownMenuItem(value: ThemeMode.light, child: Text(l.lightTheme)),
            DropdownMenuItem(value: ThemeMode.dark, child: Text(l.darkTheme)),
          ],
          onChanged: (value) => widget.onTheme(value!),
        ),
        const SizedBox(height: Space.section),
        Text(l.coverageTitle, style: type.titleMedium),
        const SizedBox(height: Space.small),
        Text(l.coverageHint, style: type.bodyMedium),
        const SizedBox(height: Space.medium),
        Text(l.sessionHint, style: type.bodySmall),
        TextButton(
          onPressed: () => _changeRules(() {
            _district = District.dhaka;
            _weekends
              ..clear()
              ..addAll({5, 6});
            _types
              ..clear()
              ..addAll({HolidayType.general, HolidayType.executiveOrder});
            _optionalIds.clear();
            _extra.clear();
            _overrides.clear();
            _officialWorking = true;
          }),
          child: Text(l.resetRules),
        ),
      ],
    );
  }

  Future<void> _addCompany() async {
    var date = _selected;
    var name = '';
    final form = GlobalKey<FormState>();
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, update) => AlertDialog(
          title: Text(l.addCompany),
          content: SingleChildScrollView(
            child: Form(
              key: form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    onChanged: (value) => name = value,
                    autofocus: true,
                    maxLength: 80,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(labelText: l.closureName),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? l.emptyName
                        : null,
                  ),
                  const SizedBox(height: Space.medium),
                  _dateButton(
                    l.selectMonth,
                    date,
                    (value) => update(() => date = value),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l.cancel),
            ),
            FilledButton(
              onPressed: () {
                if (form.currentState!.validate()) Navigator.pop(context, true);
              },
              child: Text(l.save),
            ),
          ],
        ),
      ),
    );
    final text = name.trim();
    if (saved == true && mounted) {
      _changeRules(
        () => _extra.add(
          Holiday.company(
            id: 'company-${++_companyCounter}',
            date: date,
            nameEn: text,
            nameBn: text,
          ),
        ),
      );
    }
  }

  Future<void> _overrideHoliday(Holiday holiday, String action) async {
    DateTime? replacement;
    if (action == 'move') {
      replacement = await _pickDate(holiday.date);
      if (replacement == null || !mounted) return;
    }
    _changeRules(() {
      _overrides[holiday.id] = replacement == null
          ? HolidayOverride.remove(holiday.id)
          : HolidayOverride.move(holidayId: holiday.id, date: replacement);
      if (replacement != null) {
        _selected = replacement;
        _month = DateTime.utc(replacement.year, replacement.month);
      }
    });
  }
}
