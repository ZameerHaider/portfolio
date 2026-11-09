import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/providers/portfolio_providers.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/receipt_card.dart';
import 'portfolio_scaffold.dart';

/// Shows a small receipt "printing" while projects and experience load, then
/// cross-fades to the page. Stays at least [minDuration] so the print reads,
/// and never longer than [maxDuration]. Skipped under reduced motion.
class SplashGate extends ConsumerStatefulWidget {
  const SplashGate({
    super.key,
    this.minDuration = const Duration(milliseconds: 1300),
    this.maxDuration = const Duration(seconds: 4),
  });

  final Duration minDuration;
  final Duration maxDuration;

  @override
  ConsumerState<SplashGate> createState() => _SplashGateState();
}

class _SplashGateState extends ConsumerState<SplashGate> {
  bool _minElapsed = false;
  bool _forceDone = false;
  Timer? _minTimer;
  Timer? _maxTimer;

  @override
  void initState() {
    super.initState();
    _minTimer = Timer(widget.minDuration, () => setState(() => _minElapsed = true));
    _maxTimer = Timer(widget.maxDuration, () => setState(() => _forceDone = true));
  }

  @override
  void dispose() {
    _minTimer?.cancel();
    _maxTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watching here starts the data loading behind the splash.
    final projects = ref.watch(projectsProvider);
    final experience = ref.watch(experienceProvider);
    final loaded = !projects.isLoading && !experience.isLoading;
    final done = context.reduceMotion || _forceDone || (_minElapsed && loaded);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      switchInCurve: PortfolioMotion.ease,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
      child: done ? const PortfolioScaffold(key: ValueKey('page')) : const SplashScreen(key: ValueKey('splash')),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _progress = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final text = PortfolioType.mono(size: 13, color: c.paperInk);
    final subtle = text.copyWith(color: c.paperSubtle, fontSize: 11);

    return Scaffold(
      backgroundColor: c.ground,
      body: Center(
        child: Semantics(
          label: 'Loading Zameer Haider portfolio',
          liveRegion: true,
          child: ExcludeSemantics(
            child: PrintIn(
              duration: const Duration(milliseconds: 800),
              tilt: -1.5,
              child: Container(
                width: 260,
                padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
                decoration: BoxDecoration(
                  color: c.paper,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: c.paperLine),
                  boxShadow: [
                    BoxShadow(color: c.shadow.withValues(alpha: 0.22), offset: const Offset(0, 20), blurRadius: 40, spreadRadius: -20),
                  ],
                ),
                child: AnimatedBuilder(
                  animation: _progress,
                  builder: (context, _) {
                    final t = Curves.easeInOut.transform(_progress.value);
                    const cells = 16;
                    final filled = (t * cells).round();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('ZAMEER HAIDER', textAlign: TextAlign.center, style: text.copyWith(fontWeight: FontWeight.w500, letterSpacing: 1.6)),
                        const SizedBox(height: 2),
                        Text('FLUTTER · FINTECH · POS', textAlign: TextAlign.center, style: subtle),
                        DashedRule(color: c.paperDashed, spacing: 14),
                        Row(
                          children: [
                            Expanded(child: Text('PRINTING PORTFOLIO', style: subtle)),
                            Text('${(t * 100).round().toString().padLeft(3)}%', style: subtle),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${'█' * filled}${'░' * (cells - filled)}',
                          style: text.copyWith(color: PortfolioColors.light.accent, letterSpacing: 0),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                        DashedRule(color: c.paperDashed, spacing: 14),
                        SizedBox(height: 28, child: CustomPaint(painter: BarcodePainter(color: c.paperInk, progress: t))),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
