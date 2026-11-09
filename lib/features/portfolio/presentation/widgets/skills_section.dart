import 'package:flutter/material.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';
import 'common.dart';

class _StackGroup {
  const _StackGroup(this.label, this.title, this.items, {this.featured = false});

  final String label;
  final String title;
  final List<String> items;
  final bool featured;
}

const _groups = [
  _StackGroup('SPECIALTY', 'Hardware & payments',
      ['Sunmi POS', 'thermal printing', 'HalaPay', 'NearPay', 'SurePay', 'Tabby', 'Tamara'],
      featured: true),
  _StackGroup('CORE', 'Flutter & Dart', ['Xcode', 'Android Studio', 'FlutterFlow']),
  _StackGroup('ARCHITECTURE', 'State & structure',
      ['Riverpod', 'Bloc', 'GetX', 'Provider', 'Clean Architecture', 'MVVM', 'Server-driven UI']),
  _StackGroup('BACKEND & RELEASE', 'Cloud & delivery',
      ['Firebase', 'AWS Amplify', 'REST', 'GraphQL', 'Node.js', 'CI/CD', 'App Store Connect', 'Play Console']),
];

/// "03 — Stack": surface band with four cards; the first uses the contrast band.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(color: c.surface, border: Border.symmetric(horizontal: BorderSide(color: c.line))),
      child: ContentWidth(
        padding: const EdgeInsets.symmetric(vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Reveal(child: SectionHeading(eyebrow: '03 — Stack', title: 'What I work with')),
            const SizedBox(height: 36),
            LayoutBuilder(builder: (context, constraints) {
              // Mirrors the reference's auto-fit minmax(250px, 1fr) with 20px gaps.
              final w = constraints.maxWidth;
              final columns = w >= 250 * 4 + 60 ? 4 : (w >= 250 * 2 + 20 ? 2 : 1);
              return EqualHeightGrid(
                columns: columns,
                spacing: 20,
                runSpacing: 20,
                stagger: true,
                children: [for (final g in _groups) _StackCard(group: g)],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _StackCard extends StatelessWidget {
  const _StackCard({required this.group});

  final _StackGroup group;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final f = group.featured;
    return OutlinedCard(
      interactive: true,
      padding: const EdgeInsets.all(24),
      radius: PortfolioLayout.smallCardRadius,
      color: f ? c.band : c.surface,
      showBorder: !f,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(group.label, style: PortfolioType.mono(size: 12, color: f ? c.bandAccent : c.inkSubtle)),
          const SizedBox(height: 12),
          Text(group.title, style: PortfolioType.display(20, letterSpacing: 0, height: 1.3, color: f ? c.onBand : c.ink)),
          const SizedBox(height: 12),
          Text(group.items.join(' · '), style: PortfolioType.body(size: 15, color: f ? c.onBandMuted : c.inkMuted)),
        ],
      ),
    );
  }
}
