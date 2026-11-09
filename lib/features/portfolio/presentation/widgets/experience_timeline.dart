import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamir_professional_portfolio/core/responsive_config.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';
import 'package:zamir_professional_portfolio/features/portfolio/domain/entities/experience.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/providers/portfolio_providers.dart';
import 'common.dart';

/// "02 — Experience": heading on the left, dated list on the right.
class ExperienceTimeline extends ConsumerWidget {
  const ExperienceTimeline({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final experienceAsync = ref.watch(experienceProvider);

    const heading = SectionHeading(
      eyebrow: '02 — Experience',
      title: 'From intern to senior, shipping the whole way',
    );

    final list = experienceAsync.when(
      loading: () => Padding(
        padding: const EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator(color: c.accent)),
      ),
      error: (err, _) => Text('Could not load experience: $err', style: PortfolioType.body(color: c.accentText)),
      data: (items) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < items.length; i++)
            Reveal(
              delay: Duration(milliseconds: 70 * i),
              child: _ExperienceRow(item: items[i], isLast: i == items.length - 1),
            ),
        ],
      ),
    );

    return ContentWidth(
      padding: const EdgeInsets.symmetric(vertical: 72),
      child: ResponsiveConfig.isDesktop(context)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: Reveal(child: heading)),
                const SizedBox(width: 48),
                Expanded(flex: 2, child: list),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [const Reveal(child: heading), const SizedBox(height: 48), list],
            ),
    );
  }
}

class _ExperienceRow extends StatelessWidget {
  const _ExperienceRow({required this.item, required this.isLast});

  final Experience item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final border = BorderSide(color: c.line);

    return Hoverable(builder: (context, hovered) {
      final date = Padding(
        padding: const EdgeInsets.only(top: 4),
        child: AnimatedDefaultTextStyle(
          duration: PortfolioMotion.fast,
          style: PortfolioType.mono(color: hovered ? c.accent : c.inkSubtle),
          child: Text(item.period),
        ),
      );
      final body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${item.position} · ${item.company}', style: PortfolioType.body(size: 18, weight: FontWeight.w700, height: 1.4, color: c.ink)),
          if (item.accomplishments.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(item.accomplishments.first, style: PortfolioType.body(color: c.inkMuted)),
          ],
        ],
      );

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(border: Border(top: border, bottom: isLast ? border : BorderSide.none)),
        child: ResponsiveConfig.isMobile(context)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [date, const SizedBox(height: 6), body],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 170, child: date),
                  const SizedBox(width: 24),
                  Expanded(
                    child: AnimatedSlide(
                      offset: hovered && !context.reduceMotion ? const Offset(0.01, 0) : Offset.zero,
                      duration: PortfolioMotion.medium,
                      curve: PortfolioMotion.ease,
                      child: body,
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
