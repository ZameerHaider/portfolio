import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';

/// Values the site owner still has to fill in are written as `[LIKE THIS]`.
bool isPlaceholder(String? value) => value != null && value.trim().startsWith('[');

/// Opens [url] in a new tab. Placeholders and malformed URLs are ignored
/// instead of throwing.
Future<void> openUrl(String url) async {
  if (url.isEmpty || isPlaceholder(url)) return;
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  await launchUrl(uri, mode: LaunchMode.externalApplication, webOnlyWindowName: '_blank');
}

/// Centers content at max 1200 wide with 24px side gutters.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child, this.padding = EdgeInsets.zero});

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: PortfolioLayout.maxWidth),
        child: Padding(
          padding: padding.add(const EdgeInsets.symmetric(horizontal: PortfolioLayout.gutter)),
          child: child,
        ),
      ),
    );
  }
}

/// "01 — Selected work" eyebrow plus the section H2.
class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.eyebrow, required this.title, this.onBand = false});

  final String eyebrow;
  final String title;
  final bool onBand;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(eyebrow, style: PortfolioType.mono(color: onBand ? c.bandAccent : c.accentText)),
        const SizedBox(height: 8),
        Semantics(
          header: true,
          child: Text(
            title,
            style: PortfolioType.display(
              PortfolioType.fluid(context, min: 30, max: 44, vw: 0.04),
              color: onBand ? c.onBand : c.ink,
            ),
          ),
        ),
      ],
    );
  }
}

/// Tracks mouse hover and hands the state to [builder].
class Hoverable extends StatefulWidget {
  const Hoverable({super.key, required this.builder, this.cursor = MouseCursor.defer});

  final Widget Function(BuildContext context, bool hovered) builder;
  final MouseCursor cursor;

  @override
  State<Hoverable> createState() => _HoverableState();
}

class _HoverableState extends State<Hoverable> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: widget.builder(context, _hovered),
    );
  }
}

enum ButtonVariant { filled, outlined }

/// Rectangular CTA with a 44px minimum tap target. Lifts slightly on hover.
class PortfolioButton extends StatelessWidget {
  const PortfolioButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = ButtonVariant.filled,
    this.background,
    this.foreground,
    this.borderColor,
    this.weight = FontWeight.w600,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
    this.semanticLabel,
  });

  final String label;
  final VoidCallback onPressed;
  final ButtonVariant variant;

  /// Defaults: filled → accent / onAccent; outlined → transparent / ink.
  final Color? background;
  final Color? foreground;
  final Color? borderColor;
  final FontWeight weight;
  final EdgeInsets padding;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final filled = variant == ButtonVariant.filled;
    final fg = foreground ?? (filled ? c.onAccent : c.ink);
    final bg = background ?? c.accent;
    final border = borderColor ?? c.ink;
    final reduce = context.reduceMotion;

    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      child: Hoverable(
        builder: (context, hovered) => AnimatedSlide(
          offset: hovered && !reduce ? const Offset(0, -0.04) : Offset.zero,
          duration: PortfolioMotion.fast,
          curve: PortfolioMotion.ease,
          child: Material(
            color: filled ? bg : (hovered ? fg.withValues(alpha: 0.06) : Colors.transparent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(PortfolioLayout.buttonRadius),
              side: filled ? BorderSide.none : BorderSide(color: border),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              hoverColor: fg.withValues(alpha: 0.08),
              splashColor: fg.withValues(alpha: 0.12),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: PortfolioLayout.minTap),
                child: Padding(
                  padding: padding,
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: PortfolioType.body(color: fg, weight: weight, height: 1.25),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Inline text link: turns accent and nudges its ↗ on hover. Placeholder URLs
/// render the label next to the bracketed value and are not tappable.
class PortfolioLink extends StatelessWidget {
  const PortfolioLink({super.key, required this.label, required this.url, this.style, this.underline = true});

  final String label;
  final String url;
  final TextStyle? style;
  final bool underline;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final base = (style ?? PortfolioType.body(weight: FontWeight.w600)).copyWith(color: style?.color ?? c.ink);
    if (isPlaceholder(url)) {
      return Text.rich(TextSpan(children: [
        TextSpan(text: '$label ', style: base),
        TextSpan(text: url, style: PortfolioType.mono(size: 12, color: c.inkSubtle)),
      ]));
    }
    final reduce = context.reduceMotion;
    return Semantics(
      link: true,
      child: Hoverable(
        cursor: SystemMouseCursors.click,
        builder: (context, hovered) {
          final color = hovered ? c.accent : base.color;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => openUrl(url),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: PortfolioLayout.minTap),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: AnimatedDefaultTextStyle(
                      duration: PortfolioMotion.fast,
                      style: base.copyWith(
                        color: color,
                        decoration: underline ? TextDecoration.underline : TextDecoration.none,
                        decorationColor: color,
                      ),
                      child: Text(label),
                    ),
                  ),
                  AnimatedSlide(
                    offset: hovered && !reduce ? const Offset(0.2, -0.15) : Offset.zero,
                    duration: PortfolioMotion.fast,
                    curve: PortfolioMotion.ease,
                    child: Text(' ↗', style: base.copyWith(color: color)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Small monospace tech tag.
class TechTag extends StatelessWidget {
  const TechTag(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: c.line),
        borderRadius: BorderRadius.circular(PortfolioLayout.tagRadius),
      ),
      child: Text(label, style: PortfolioType.mono(size: 12, color: c.ink)),
    );
  }
}

class TagWrap extends StatelessWidget {
  const TagWrap(this.tags, {super.key});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 8, runSpacing: 8, children: [for (final t in tags) TechTag(t)]);
  }
}

/// Bordered card. With [interactive] it lifts 4px and darkens its border on
/// hover.
class OutlinedCard extends StatelessWidget {
  const OutlinedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(28),
    this.radius = PortfolioLayout.cardRadius,
    this.color,
    this.borderColor,
    this.showBorder = true,
    this.interactive = false,
    this.hovered,
  });

  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? color;
  final Color? borderColor;
  final bool showBorder;
  final bool interactive;

  /// Hover state driven by a parent [Hoverable] (overrides [interactive]).
  final bool? hovered;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    Widget card(bool hovered) {
      final lift = hovered && !context.reduceMotion;
      return AnimatedContainer(
        duration: PortfolioMotion.medium,
        curve: PortfolioMotion.ease,
        transform: Matrix4.translationValues(0, lift ? -4 : 0, 0),
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? c.surface,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: hovered ? c.lineStrong : (borderColor ?? c.line)) : null,
          boxShadow: [
            BoxShadow(
              color: c.shadow.withValues(alpha: lift ? 0.12 : 0),
              offset: const Offset(0, 18),
              blurRadius: 36,
              spreadRadius: -18,
            ),
          ],
        ),
        child: child,
      );
    }

    if (hovered != null) return card(hovered!);
    if (!interactive) return card(false);
    return Hoverable(builder: (context, hovered) => card(hovered));
  }
}

/// Project screenshot, or a striped placeholder box when the asset is missing
/// or fails to load. Zooms gently when [zoom] is true.
class ProjectImage extends StatelessWidget {
  const ProjectImage({super.key, required this.asset, required this.label, required this.aspectRatio, this.zoom = false});

  final String? asset;
  final String label;
  final double aspectRatio;
  final bool zoom;

  @override
  Widget build(BuildContext context) {
    final placeholder = _StripedPlaceholder(label: label);
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: AnimatedScale(
          scale: zoom && !context.reduceMotion ? 1.03 : 1,
          duration: PortfolioMotion.slow,
          curve: PortfolioMotion.ease,
          child: asset == null || asset!.isEmpty
              ? placeholder
              : Image.asset(
                  asset!,
                  fit: BoxFit.cover,
                  semanticLabel: '$label screenshot',
                  errorBuilder: (_, _, _) => placeholder,
                ),
        ),
      ),
    );
  }
}

class _StripedPlaceholder extends StatelessWidget {
  const _StripedPlaceholder({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return CustomPaint(
      painter: _StripePainter(base: c.ground, stripe: c.stripe),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('[$label — screenshots]', textAlign: TextAlign.center, style: PortfolioType.mono(color: c.inkSubtle)),
        ),
      ),
    );
  }
}

/// 135° stripes, 12px each, matching the reference placeholder.
class _StripePainter extends CustomPainter {
  _StripePainter({required this.base, required this.stripe});

  final Color base;
  final Color stripe;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = base);
    final paint = Paint()..color = stripe;
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    // 24px period along the 135° gradient axis → ×√2 horizontally.
    const step = 24 * 1.4142;
    const band = 12 * 1.4142;
    final h = size.height;
    for (double x = 0; x < size.width + h + step; x += step) {
      final path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + band, 0)
        ..lineTo(x + band - h, h)
        ..lineTo(x - h, h)
        ..close();
      canvas.drawPath(path, paint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _StripePainter old) => old.base != base || old.stripe != stripe;
}

/// Fade-and-rise when the child first scrolls into view, after [delay]
/// (for staggering siblings). Shown immediately under reduced motion.
class Reveal extends StatefulWidget {
  const Reveal({super.key, required this.child, this.delay = Duration.zero, this.offset = 24, this.onLoad = false});

  final Widget child;
  final Duration delay;

  /// Play on first build regardless of scroll position (for above-the-fold
  /// content such as the hero).
  final bool onLoad;

  /// Rise distance in logical pixels.
  final double offset;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> {
  bool _triggered = false;
  bool _visible = false;
  ScrollPosition? _position;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_triggered) return;
    _position?.removeListener(_check);
    _position = Scrollable.maybeOf(context)?.position;
    _position?.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!mounted || _triggered) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached || !box.hasSize) return;
    final top = box.localToGlobal(Offset.zero).dy;
    if (widget.onLoad || top < MediaQuery.sizeOf(context).height * 0.92) {
      _triggered = true;
      _position?.removeListener(_check);
      if (widget.delay == Duration.zero) {
        setState(() => _visible = true);
      } else {
        _timer = Timer(widget.delay, () {
          if (mounted) setState(() => _visible = true);
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _position?.removeListener(_check);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return widget.child;
    return TweenAnimationBuilder<double>(
      tween: Tween(end: _visible ? 1 : 0),
      duration: const Duration(milliseconds: 500),
      curve: PortfolioMotion.ease,
      child: widget.child,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(0, (1 - t) * widget.offset), child: child),
      ),
    );
  }
}

/// Lays [children] out in rows of [columns] equal-width, equal-height cells.
/// With [stagger], each cell reveals a little after the one before it.
class EqualHeightGrid extends StatelessWidget {
  const EqualHeightGrid({
    super.key,
    required this.columns,
    required this.children,
    this.spacing = 24,
    this.runSpacing = 24,
    this.stagger = false,
  });

  final int columns;
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final bool stagger;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += columns) {
      final cells = <Widget>[];
      for (var col = 0; col < columns; col++) {
        if (col > 0) cells.add(SizedBox(width: spacing));
        final idx = i + col;
        Widget cell = idx < children.length ? children[idx] : const SizedBox.shrink();
        if (stagger && idx < children.length) {
          cell = Reveal(delay: Duration(milliseconds: 90 * col), child: cell);
        }
        cells.add(Expanded(child: cell));
      }
      if (rows.isNotEmpty && runSpacing > 0) rows.add(SizedBox(height: runSpacing));
      rows.add(IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: cells)));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }
}

/// Sun/moon button that flips the theme, with a rotating swap.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key, required this.onToggle, this.color});

  final VoidCallback onToggle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final c = context.colors;
    return IconButton(
      tooltip: isDark ? 'Switch to light theme' : 'Switch to dark theme',
      constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      onPressed: onToggle,
      icon: AnimatedSwitcher(
        duration: context.reduceMotion ? Duration.zero : PortfolioMotion.medium,
        transitionBuilder: (child, anim) => RotationTransition(
          turns: Tween(begin: 0.6, end: 1.0).animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(isDark),
          size: 20,
          color: color ?? c.ink,
        ),
      ),
    );
  }
}
