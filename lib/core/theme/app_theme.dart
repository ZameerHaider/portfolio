import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Design tokens for the editorial "receipt" look, in a light and a dark set.
/// Widgets read them with `context.colors`; no hex values live in widgets.
@immutable
class PortfolioColors extends ThemeExtension<PortfolioColors> {
  const PortfolioColors({
    required this.ground,
    required this.surface,
    required this.ink,
    required this.inkMuted,
    required this.inkSubtle,
    required this.line,
    required this.lineStrong,
    required this.dashed,
    required this.accent,
    required this.onAccent,
    required this.accentText,
    required this.success,
    required this.stripe,
    required this.band,
    required this.onBand,
    required this.onBandMuted,
    required this.onBandLine,
    required this.onBandDivider,
    required this.onBandFaint,
    required this.bandAccent,
    required this.onBandAccent,
    required this.paper,
    required this.paperInk,
    required this.paperSubtle,
    required this.paperDashed,
    required this.paperLine,
    required this.shadow,
  });

  /// Page background.
  final Color ground;

  /// Cards, platform strip, stack band.
  final Color surface;

  /// Primary text and dark buttons.
  final Color ink;

  /// Body copy.
  final Color inkMuted;

  /// Meta labels, dates.
  final Color inkSubtle;

  /// 1px borders and dividers.
  final Color line;

  /// Borders on hover.
  final Color lineStrong;
  final Color dashed;

  /// Headline highlight and primary button.
  final Color accent;
  final Color onAccent;

  /// Small eyebrow labels on the page background.
  final Color accentText;
  final Color success;

  /// Second tone of the striped image placeholder.
  final Color stripe;

  /// The one contrasting band (contact section, specialty card). Dark on the
  /// light theme, cream on the dark theme.
  final Color band;
  final Color onBand;
  final Color onBandMuted;
  final Color onBandLine;
  final Color onBandDivider;
  final Color onBandFaint;
  final Color bandAccent;
  final Color onBandAccent;

  /// The receipt stays paper-coloured in both themes.
  final Color paper;
  final Color paperInk;
  final Color paperSubtle;
  final Color paperDashed;
  final Color paperLine;
  final Color shadow;

  static const light = PortfolioColors(
    ground: Color(0xFFF5F4EF),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF121316),
    inkMuted: Color(0xFF3F4349),
    inkSubtle: Color(0xFF565A61),
    line: Color(0xFFDEDBD2),
    lineStrong: Color(0xFFB9B5AA),
    dashed: Color(0xFFB9B5AA),
    accent: Color(0xFFC2410C),
    onAccent: Color(0xFFFFFFFF),
    accentText: Color(0xFF8A3010),
    success: Color(0xFF1E8A4C),
    stripe: Color(0xFFEEEBE3),
    band: Color(0xFF121316),
    onBand: Color(0xFFF5F4EF),
    onBandMuted: Color(0xFFD6D3CB),
    onBandLine: Color(0xFF5B5E64),
    onBandDivider: Color(0xFF2C2E33),
    onBandFaint: Color(0xFFA9A69E),
    bandAccent: Color(0xFFFF9466),
    onBandAccent: Color(0xFF121316),
    paper: Color(0xFFFFFFFF),
    paperInk: Color(0xFF121316),
    paperSubtle: Color(0xFF565A61),
    paperDashed: Color(0xFFB9B5AA),
    paperLine: Color(0xFFDEDBD2),
    shadow: Color(0xFF121316),
  );

  static const dark = PortfolioColors(
    ground: Color(0xFF101113),
    surface: Color(0xFF18191C),
    ink: Color(0xFFEDEBE4),
    inkMuted: Color(0xFFC2BFB6),
    inkSubtle: Color(0xFF9C998F),
    line: Color(0xFF2A2C31),
    lineStrong: Color(0xFF4A4D53),
    dashed: Color(0xFF4A4D53),
    accent: Color(0xFFFF8A5B),
    onAccent: Color(0xFF121316),
    accentText: Color(0xFFFF9466),
    success: Color(0xFF3DBE73),
    stripe: Color(0xFF1F2125),
    band: Color(0xFFF5F4EF),
    onBand: Color(0xFF121316),
    onBandMuted: Color(0xFF3F4349),
    onBandLine: Color(0xFF8F8B81),
    onBandDivider: Color(0xFFDEDBD2),
    onBandFaint: Color(0xFF565A61),
    bandAccent: Color(0xFFC2410C),
    onBandAccent: Color(0xFFFFFFFF),
    paper: Color(0xFFF2F0E9),
    paperInk: Color(0xFF121316),
    paperSubtle: Color(0xFF565A61),
    paperDashed: Color(0xFFB9B5AA),
    paperLine: Color(0xFF2A2C31),
    shadow: Color(0xFF000000),
  );

  @override
  PortfolioColors copyWith() => this;

  @override
  PortfolioColors lerp(ThemeExtension<PortfolioColors>? other, double t) {
    if (other is! PortfolioColors) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return PortfolioColors(
      ground: l(ground, other.ground),
      surface: l(surface, other.surface),
      ink: l(ink, other.ink),
      inkMuted: l(inkMuted, other.inkMuted),
      inkSubtle: l(inkSubtle, other.inkSubtle),
      line: l(line, other.line),
      lineStrong: l(lineStrong, other.lineStrong),
      dashed: l(dashed, other.dashed),
      accent: l(accent, other.accent),
      onAccent: l(onAccent, other.onAccent),
      accentText: l(accentText, other.accentText),
      success: l(success, other.success),
      stripe: l(stripe, other.stripe),
      band: l(band, other.band),
      onBand: l(onBand, other.onBand),
      onBandMuted: l(onBandMuted, other.onBandMuted),
      onBandLine: l(onBandLine, other.onBandLine),
      onBandDivider: l(onBandDivider, other.onBandDivider),
      onBandFaint: l(onBandFaint, other.onBandFaint),
      bandAccent: l(bandAccent, other.bandAccent),
      onBandAccent: l(onBandAccent, other.onBandAccent),
      paper: l(paper, other.paper),
      paperInk: l(paperInk, other.paperInk),
      paperSubtle: l(paperSubtle, other.paperSubtle),
      paperDashed: l(paperDashed, other.paperDashed),
      paperLine: l(paperLine, other.paperLine),
      shadow: l(shadow, other.shadow),
    );
  }
}

extension PortfolioThemeX on BuildContext {
  PortfolioColors get colors => Theme.of(this).extension<PortfolioColors>()!;

  /// True when the platform asks for reduced motion.
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);
}

/// Layout constants shared across sections.
abstract final class PortfolioLayout {
  static const double maxWidth = 1200;
  static const double gutter = 24;
  static const double cardRadius = 16;
  static const double smallCardRadius = 12;
  static const double buttonRadius = 8;
  static const double tagRadius = 6;
  static const double minTap = 44;
}

/// Motion constants. Every animation checks `context.reduceMotion` first.
abstract final class PortfolioMotion {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 700);
  static const Curve ease = Curves.easeOutCubic;
}

/// Type scale. Display uses Space Grotesk, body Inter, labels JetBrains Mono.
/// A null colour inherits from the surrounding text style (the theme's ink).
abstract final class PortfolioType {
  static TextStyle display(double size, {Color? color, double height = 1.1, double letterSpacing = -0.02}) =>
      GoogleFonts.spaceGrotesk(
        fontSize: size,
        fontWeight: FontWeight.w700,
        height: height,
        letterSpacing: size * letterSpacing,
        color: color,
      );

  static TextStyle body({double size = 16, Color? color, FontWeight weight = FontWeight.w400, double height = 1.6}) =>
      GoogleFonts.inter(fontSize: size, fontWeight: weight, height: height, color: color);

  static TextStyle mono({double size = 13, Color? color, FontWeight weight = FontWeight.w400, double letterSpacing = 0, double height = 1.5}) =>
      GoogleFonts.jetBrainsMono(fontSize: size, fontWeight: weight, color: color, letterSpacing: letterSpacing, height: height);

  /// CSS-style clamp(min, vw * factor, max) against the viewport width.
  static double fluid(BuildContext context, {required double min, required double max, required double vw}) =>
      (MediaQuery.sizeOf(context).width * vw).clamp(min, max);
}

class AppTheme {
  static ThemeData get light => _build(PortfolioColors.light, Brightness.light);
  static ThemeData get dark => _build(PortfolioColors.dark, Brightness.dark);

  static ThemeData _build(PortfolioColors c, Brightness brightness) {
    final base = ThemeData(useMaterial3: true, brightness: brightness);
    return base.copyWith(
      extensions: [c],
      scaffoldBackgroundColor: c.ground,
      colorScheme: ColorScheme.fromSeed(seedColor: c.accent, brightness: brightness).copyWith(
        primary: c.accent,
        onPrimary: c.onAccent,
        secondary: c.ink,
        surface: c.surface,
        onSurface: c.ink,
        outline: c.line,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(bodyColor: c.ink, displayColor: c.ink),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.accent,
        selectionColor: c.accent.withValues(alpha: 0.25),
      ),
      dividerColor: c.line,
      drawerTheme: DrawerThemeData(backgroundColor: c.ground, shape: const RoundedRectangleBorder()),
      iconTheme: IconThemeData(color: c.ink),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(color: c.ink, borderRadius: BorderRadius.circular(6)),
        textStyle: PortfolioType.mono(size: 12, color: c.ground),
      ),
    );
  }
}
