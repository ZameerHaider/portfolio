import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';

/// The hero "receipt": a slightly rotated paper slip summarising credentials.
/// On first build it prints in from the top, then settles to its tilt.
class ReceiptCard extends StatelessWidget {
  const ReceiptCard({super.key, this.delay = const Duration(milliseconds: 250)});

  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final text = PortfolioType.mono(size: 14, color: c.paperInk);
    final subtle = text.copyWith(color: c.paperSubtle);

    Widget row(String left, String right, {TextStyle? style, TextStyle? rightStyle, double indent = 0}) {
      final s = style ?? text;
      return Padding(
        padding: EdgeInsets.only(left: indent),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(left, style: s)),
            const SizedBox(width: 12),
            Text(right, style: rightStyle ?? s, textAlign: TextAlign.right),
          ],
        ),
      );
    }

    final rows = <Widget>[
      row('Years shipping Flutter', '6+'),
      row('Live App Store apps', '6'),
      row('Payment terminals', '3'),
      row('HalaPay', '✓', style: subtle, indent: 16),
      row('NearPay', '✓', style: subtle, indent: 16),
      row('SurePay', '✓', style: subtle, indent: 16),
      row('BNPL gateways', 'Tabby, Tamara'),
    ];

    final slip = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 380),
      child: Container(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
        decoration: BoxDecoration(
          color: c.paper,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: c.paperLine),
          boxShadow: [
            BoxShadow(
              color: c.shadow.withValues(alpha: 0.25),
              offset: const Offset(0, 24),
              blurRadius: 48,
              spreadRadius: -24,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ZAMEER HAIDER', textAlign: TextAlign.center, style: text.copyWith(fontWeight: FontWeight.w500, letterSpacing: 14 * 0.12)),
            const SizedBox(height: 2),
            Text('FLUTTER · FINTECH · POS', textAlign: TextAlign.center, style: subtle.copyWith(fontSize: 12)),
            DashedRule(color: c.paperDashed),
            for (var i = 0; i < rows.length; i++) ...[
              if (i > 0) const SizedBox(height: 8),
              rows[i],
            ],
            DashedRule(color: c.paperDashed),
            row(
              'STATUS',
              'OPEN TO WORK',
              style: text.copyWith(fontWeight: FontWeight.w500),
              rightStyle: text.copyWith(fontWeight: FontWeight.w500, color: PortfolioColors.light.accent),
            ),
            const SizedBox(height: 22),
            ExcludeSemantics(
              child: SizedBox(height: 36, child: CustomPaint(painter: BarcodePainter(color: c.paperInk))),
            ),
          ],
        ),
      ),
    );

    return PrintIn(delay: delay, child: slip);
  }
}

/// Reveals [child] top-down like paper feeding out of a printer, then eases
/// it into a 1.5° tilt. Static under reduced motion.
class PrintIn extends StatefulWidget {
  const PrintIn({super.key, required this.child, this.delay = Duration.zero, this.tilt = 1.5, this.duration = const Duration(milliseconds: 900)});

  final Widget child;
  final Duration delay;
  final double tilt;
  final Duration duration;

  @override
  State<PrintIn> createState() => _PrintInState();
}

class _PrintInState extends State<PrintIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: widget.duration);
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (context.reduceMotion) {
      _controller.value = 1;
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feed = CurvedAnimation(parent: _controller, curve: const Interval(0, 0.75, curve: Curves.easeInOutCubic));
    final settle = CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1, curve: Curves.easeOutBack));
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final angle = settle.value * widget.tilt * math.pi / 180;
        final done = _controller.isCompleted;
        return Transform.rotate(
          angle: angle,
          child: done
              ? child
              : ClipRect(
                  child: Align(
                    alignment: Alignment.topCenter,
                    heightFactor: feed.value,
                    child: Opacity(opacity: (feed.value * 3).clamp(0.0, 1.0), child: child),
                  ),
                ),
        );
      },
    );
  }
}

class DashedRule extends StatelessWidget {
  const DashedRule({super.key, required this.color, this.spacing = 18});

  final Color color;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: spacing),
      child: SizedBox(height: 1, width: double.infinity, child: CustomPaint(painter: _DashPainter(color))),
    );
  }
}

class _DashPainter extends CustomPainter {
  _DashPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const dash = 3.0, gap = 3.0;
    for (double x = 0; x < size.width; x += dash + gap) {
      canvas.drawRect(Rect.fromLTWH(x, 0, math.min(dash, size.width - x), 1), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DashPainter old) => old.color != color;
}

/// Decorative barcode: vertical bars on a repeating 9px pattern
/// (2px bar, 2px gap, 1px bar, 4px gap), like the reference. [progress]
/// draws it left to right.
class BarcodePainter extends CustomPainter {
  BarcodePainter({required this.color, this.progress = 1});

  final Color color;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final limit = size.width * progress;
    for (double x = 0; x < limit; x += 9) {
      canvas.drawRect(Rect.fromLTWH(x, 0, math.min(2, limit - x), size.height), paint);
      if (x + 4 < limit) canvas.drawRect(Rect.fromLTWH(x + 4, 0, 1, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant BarcodePainter old) => old.color != color || old.progress != progress;
}
