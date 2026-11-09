import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zamir_professional_portfolio/core/theme/theme_provider.dart';
import 'package:zamir_professional_portfolio/features/portfolio/domain/entities/experience.dart';
import 'package:zamir_professional_portfolio/features/portfolio/domain/entities/project.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/providers/portfolio_providers.dart';
import 'package:zamir_professional_portfolio/main.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

  final config = jsonDecode(File('assets/specs/portfolio_config.json').readAsStringSync()) as Map<String, dynamic>;
  final projects = (config['projects'] as List).map((e) => Project.fromJson(e as Map<String, dynamic>)).toList()
    ..sort((a, b) => (a.order ?? 0).compareTo(b.order ?? 0));
  final experience = (config['experience'] as List).map((e) => Experience.fromJson(e as Map<String, dynamic>)).toList();

  /// The full app (splash → page) with data from the JSON seed. Optionally
  /// forces a theme mode.
  Widget app({ThemeMode? mode}) {
    const child = PortfolioApp();
    return ProviderScope(
      overrides: [
        projectsProvider.overrideWith((ref) => Stream.value(projects)),
        experienceProvider.overrideWith((ref) => Stream.value(experience)),
        if (mode != null) themeModeNotifierProvider.overrideWith(() => _FixedTheme(mode)),
      ],
      child: child,
    );
  }

  void setSize(WidgetTester tester, double width) {
    tester.view.physicalSize = Size(width, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }

  /// Animations repeat (the status pulse), so advance time rather than settle.
  Future<void> pass(WidgetTester tester, [int ms = 2500]) async {
    for (var i = 0; i < ms ~/ 100; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  test('seed JSON parses with the new fields', () {
    expect(projects.first.id, 'bryde');
    expect(projects.first.tier, 'featured');
    expect(projects.where((p) => p.tier == 'case').length, 3);
    expect(projects.where((p) => p.tier == 'more').length, 6);
    expect(experience.first.company, 'BRYDE');
  });

  test('old Firestore docs without the new fields still parse', () {
    final p = Project.fromJson({
      'id': 'pms',
      'title': 'PMS',
      'role': 'Dev',
      'description': 'x',
      'techStack': ['Flutter'],
      'impactMetrics': ['a'],
      'liveLink': '',
    });
    expect(p.tier, 'more');
    expect(p.highlights, isEmpty);
  });

  testWidgets('splash prints, then hands over to the page', (tester) async {
    setSize(tester, 1440);
    await tester.pumpWidget(app(mode: ThemeMode.light));
    await tester.pump();
    expect(find.text('PRINTING PORTFOLIO'), findsOneWidget);
    expect(find.text('Hire me'), findsNothing);
    await pass(tester);
    expect(find.text('PRINTING PORTFOLIO'), findsNothing);
    expect(find.text('Hire me'), findsOneWidget);
  });

  testWidgets('hero entrance animations finish fully visible', (tester) async {
    // Short viewport: hero content below the fold must still animate in.
    tester.view.physicalSize = const Size(1440, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app(mode: ThemeMode.light));
    await pass(tester, 4000);
    double opacityOf(Finder f) => tester
        .widgetList<Opacity>(find.ancestor(of: f, matching: find.byType(Opacity)))
        .fold(1.0, (acc, o) => acc * o.opacity);
    for (final text in ['Download CV (PDF)', 'ZAMEER HAIDER', 'Web', 'GitHub']) {
      expect(opacityOf(find.text(text).first), 1.0, reason: text);
    }
    // The receipt finished printing: nothing is still clipping its height.
    final partial = tester
        .widgetList<Align>(find.ancestor(of: find.text('OPEN TO WORK'), matching: find.byType(Align)))
        .where((a) => (a.heightFactor ?? 1) < 1);
    expect(partial, isEmpty);
  });

  testWidgets('reduced motion skips the splash', (tester) async {
    setSize(tester, 1440);
    tester.platformDispatcher.accessibilityFeaturesTestValue = const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
    await tester.pumpWidget(app(mode: ThemeMode.light));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.text('PRINTING PORTFOLIO'), findsNothing);
    expect(find.text('Hire me'), findsOneWidget);
  });

  testWidgets('theme toggle flips light ↔ dark', (tester) async {
    setSize(tester, 1440);
    await tester.pumpWidget(app()); // follows the (light) test platform
    await pass(tester);
    BuildContext ctx() => tester.element(find.text('Hire me'));
    expect(Theme.of(ctx()).brightness, Brightness.light);

    await tester.tap(find.byTooltip('Switch to dark theme'));
    await pass(tester, 800);
    expect(Theme.of(ctx()).brightness, Brightness.dark);

    await tester.tap(find.byTooltip('Switch to light theme'));
    await pass(tester, 800);
    expect(Theme.of(ctx()).brightness, Brightness.light);
  });

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    for (final width in [375.0, 768.0, 1440.0]) {
      testWidgets('${mode.name} theme renders without overflow at ${width.toInt()}px', (tester) async {
        setSize(tester, width);
        await tester.pumpWidget(app(mode: mode));
        await pass(tester);

        expect(find.text('BRYDE — a two-sided rental marketplace for premium vehicles'), findsOneWidget);
        expect(find.text('Lead Developer (client project) · BRYDE'), findsOneWidget);
        // Placeholders render verbatim.
        expect(find.text('[START] — now'), findsOneWidget);
        expect(find.text('[PORTAL STACK]'), findsOneWidget);
        // Nav collapses to a menu under 600.
        expect(find.byTooltip('Open menu'), width < 600 ? findsOneWidget : findsNothing);
        expect(find.text('Hire me'), width < 600 ? findsNothing : findsOneWidget);
        // GitHub / LinkedIn appear in the hero (and the nav on wider screens).
        expect(find.text('GitHub'), findsOneWidget);
        expect(find.text('LinkedIn'), findsOneWidget);

        if (width < 600) {
          await tester.tap(find.byTooltip('Open menu'));
          await pass(tester, 800);
          expect(find.text('Contact'), findsOneWidget);
          expect(find.bySemanticsLabel('GitHub profile'), findsWidgets);
          await tester.tapAt(const Offset(370, 400)); // close the drawer
          await pass(tester, 800);
        }

        // Scroll through the whole page so every section lays out and reveals.
        final scrollable = find.byType(Scrollable).first;
        for (var i = 0; i < 40; i++) {
          await tester.drag(scrollable, const Offset(0, -400));
          await tester.pump(const Duration(milliseconds: 50));
        }
        await pass(tester, 1500);
        expect(find.text('Built with Flutter'), findsOneWidget);
        expect(tester.takeException(), isNull);
      });
    }
  }
}

class _FixedTheme extends ThemeModeNotifier {
  _FixedTheme(this.mode);

  final ThemeMode mode;

  @override
  ThemeMode build() => mode;
}
