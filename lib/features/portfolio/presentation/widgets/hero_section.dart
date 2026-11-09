import 'package:flutter/material.dart';
import 'package:zamir_professional_portfolio/core/site_config.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';
import 'common.dart';
import 'receipt_card.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onSeeWork, required this.onDownloadCv});

  final VoidCallback onSeeWork;
  final VoidCallback onDownloadCv;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final h1 = PortfolioType.display(
      PortfolioType.fluid(context, min: 40, max: 68, vw: 0.06),
      height: 1.02,
      letterSpacing: -0.03,
      color: c.ink,
    );

    // Staggered entrance: each line rises 80ms after the one before.
    Widget step(int i, Widget child) => Reveal(onLoad: true, delay: Duration(milliseconds: 80 * i), child: child);

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        step(0, const _AvailabilityPill()),
        const SizedBox(height: 28),
        step(
          1,
          Semantics(
            header: true,
            child: Text.rich(
              TextSpan(children: [
                const TextSpan(text: 'I build Flutter apps that '),
                TextSpan(text: 'take payments', style: h1.copyWith(color: c.accent)),
                const TextSpan(text: ' and ship to the store.'),
              ]),
              style: h1,
            ),
          ),
        ),
        const SizedBox(height: 28),
        step(
          2,
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 34 * 19),
            child: Text(
              'Senior Flutter developer with 6+ years in fintech, ecommerce and POS — from app architecture '
              'to card-terminal integration to App Store release. Based in Lahore, working with teams worldwide.',
              style: PortfolioType.body(size: 19, color: c.inkMuted),
            ),
          ),
        ),
        const SizedBox(height: 28),
        step(
          3,
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              PortfolioButton(label: 'See selected work', onPressed: onSeeWork),
              PortfolioButton(label: 'Download CV (PDF)', onPressed: onDownloadCv, variant: ButtonVariant.outlined),
            ],
          ),
        ),
        const SizedBox(height: 16),
        step(4, const SocialLinks()),
      ],
    );

    return ContentWidth(
      padding: const EdgeInsets.only(top: 88, bottom: 72),
      child: LayoutBuilder(builder: (context, constraints) {
        // Two columns once both can be at least 420 wide (plus the 56 gap).
        if (constraints.maxWidth >= 420 * 2 + 56) {
          return Row(
            children: [
              Expanded(child: copy),
              const SizedBox(width: 56),
              const Expanded(child: Center(child: ReceiptCard())),
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [copy, const SizedBox(height: 56), const Center(child: ReceiptCard(delay: Duration(milliseconds: 400)))],
        );
      }),
    );
  }
}

/// Monospace GitHub / LinkedIn links.
class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final style = PortfolioType.mono(size: 14, color: color ?? context.colors.inkMuted, weight: FontWeight.w500);
    return Wrap(
      spacing: 24,
      children: [
        PortfolioLink(label: 'GitHub', url: SiteConfig.githubUrl, style: style, underline: false),
        PortfolioLink(label: 'LinkedIn', url: SiteConfig.linkedInUrl, style: style, underline: false),
      ],
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  const _AvailabilityPill();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: c.surface,
        border: Border.all(color: c.line),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PulseDot(color: c.success),
          const SizedBox(width: 10),
          Flexible(child: Text('Available for remote & relocation roles', style: PortfolioType.mono(color: c.inkMuted))),
        ],
      ),
    );
  }
}

/// Green status dot with a soft expanding ring, like a live indicator.
class _PulseDot extends StatefulWidget {
  const _PulseDot({required this.color});

  final Color color;

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dot = Container(width: 8, height: 8, decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle));
    return SizedBox(
      width: 8,
      height: 8,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = Curves.easeOut.transform(_controller.value);
              return Transform.scale(
                scale: 1 + t * 1.6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: widget.color.withValues(alpha: (1 - t) * 0.45), shape: BoxShape.circle),
                ),
              );
            },
          ),
          dot,
        ],
      ),
    );
  }
}

class PlatformStrip extends StatelessWidget {
  const PlatformStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    const platforms = ['iOS App Store', 'Google Play', 'Sunmi POS', 'Android payment terminals', 'Web'];
    return DecoratedBox(
      decoration: BoxDecoration(color: c.surface, border: Border.symmetric(horizontal: BorderSide(color: c.line))),
      child: ContentWidth(
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: Semantics(
          label: 'Platforms',
          container: true,
          child: Wrap(
            spacing: 40,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text('Shipped on', style: PortfolioType.mono(color: c.ink, weight: FontWeight.w500)),
              for (var i = 0; i < platforms.length; i++)
                Reveal(
                  onLoad: true,
                  delay: Duration(milliseconds: 500 + 60 * i),
                  offset: 8,
                  child: Text(platforms[i], style: PortfolioType.mono(color: c.inkMuted)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
