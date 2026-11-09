import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamir_professional_portfolio/core/responsive_config.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';
import 'package:zamir_professional_portfolio/features/portfolio/domain/entities/project.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/providers/portfolio_providers.dart';
import 'common.dart';

/// "01 — Selected work": featured case study, case-study cards, more projects.
class ProjectGrid extends ConsumerWidget {
  const ProjectGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsProvider);
    final c = context.colors;

    return ContentWidth(
      padding: const EdgeInsets.only(top: 96, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Reveal(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: 16,
              runSpacing: 16,
              children: [
                const SectionHeading(eyebrow: '01 — Selected work', title: 'Products real businesses run on'),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 28 * 16),
                  child: Text(
                    'A full rental marketplace I built end to end, my work at Ignite, then earlier projects.',
                    style: PortfolioType.body(color: c.inkMuted),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          projectsAsync.when(
            loading: () => Padding(
              padding: const EdgeInsets.all(48),
              child: Center(child: CircularProgressIndicator(color: c.accent)),
            ),
            error: (err, _) => Text('Could not load projects: $err', style: PortfolioType.body(color: c.accentText)),
            data: (projects) => _WorkBody(projects: projects),
          ),
        ],
      ),
    );
  }
}

class _WorkBody extends StatelessWidget {
  const _WorkBody({required this.projects});

  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final featured = projects.where((p) => p.tier == 'featured').toList();
    final cases = projects.where((p) => p.tier == 'case').toList();
    final more = projects.where((p) => p.tier != 'featured' && p.tier != 'case').toList();

    final caseColumns = ResponsiveConfig.isDesktop(context)
        ? 3
        : ResponsiveConfig.isTablet(context)
            ? 2
            : 1;
    final moreColumns = caseColumns;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final p in featured) ...[
          Reveal(child: FeaturedCaseStudy(project: p)),
          const SizedBox(height: 40),
        ],
        if (cases.isNotEmpty) ...[
          EqualHeightGrid(
              columns: caseColumns,
              stagger: true,
              children: [for (final p in cases) CaseStudyCard(project: p)],
          ),
          const SizedBox(height: 40),
        ],
        if (more.isNotEmpty)
          Reveal(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
                  child: Text('More projects', style: PortfolioType.display(20, letterSpacing: 0, height: 1.3)),
                ),
                Container(
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: context.colors.line))),
                  child: EqualHeightGrid(
                    columns: moreColumns,
                    spacing: 0,
                    runSpacing: 0,
                    children: [for (final p in more) _MoreProjectRow(project: p)],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

List<Widget> _storeLinks(Project p) => [
      if (p.liveLink.isNotEmpty) PortfolioLink(label: _hostOf(p.liveLink), url: p.liveLink),
      if ((p.appStoreLink ?? '').isNotEmpty) PortfolioLink(label: 'App Store', url: p.appStoreLink!),
      if ((p.playStoreLink ?? '').isNotEmpty) PortfolioLink(label: 'Google Play', url: p.playStoreLink!),
    ];

String _hostOf(String url) {
  final host = Uri.tryParse(url)?.host ?? '';
  return host.isEmpty ? 'Website' : host.replaceFirst('www.', '');
}

class FeaturedCaseStudy extends StatelessWidget {
  const FeaturedCaseStudy({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final p = project;
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (p.meta != null) Text(p.meta!, style: PortfolioType.mono(color: c.inkSubtle)),
        const SizedBox(height: 18),
        Text(p.headline ?? p.title, style: PortfolioType.display(30, height: 1.15, letterSpacing: -0.01, color: c.ink)),
        const SizedBox(height: 18),
        Text(p.description, style: PortfolioType.body(color: c.inkMuted)),
        if (p.highlights.isNotEmpty) ...[
          const SizedBox(height: 18),
          for (final h in p.highlights)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 20, child: Text('•', style: PortfolioType.body(color: c.accent))),
                  Expanded(child: Text(h, style: PortfolioType.body(color: c.ink))),
                ],
              ),
            ),
        ],
        const SizedBox(height: 18),
        TagWrap(p.techStack),
        const SizedBox(height: 18),
        Wrap(spacing: 20, runSpacing: 4, children: _storeLinks(p)),
      ],
    );

    return Hoverable(
      builder: (context, hovered) => OutlinedCard(
        hovered: hovered,
        padding: const EdgeInsets.all(32),
        child: LayoutBuilder(builder: (context, constraints) {
          final image = ProjectImage(asset: p.imageAsset, label: p.title, aspectRatio: 4 / 3, zoom: hovered);
          if (constraints.maxWidth >= 440 * 2 + 40) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: image),
                const SizedBox(width: 40),
                Expanded(child: text),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [image, const SizedBox(height: 32), text],
          );
        }),
      ),
    );
  }
}

class CaseStudyCard extends StatelessWidget {
  const CaseStudyCard({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final p = project;
    final links = _storeLinks(p);
    return Hoverable(
      builder: (context, hovered) => OutlinedCard(
        hovered: hovered,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectImage(asset: p.imageAsset, label: p.title, aspectRatio: 16 / 9, zoom: hovered),
            const SizedBox(height: 16),
            if (p.meta != null) ...[
              Text(p.meta!, style: PortfolioType.mono(color: c.inkSubtle)),
              const SizedBox(height: 16),
            ],
            AnimatedDefaultTextStyle(
              duration: PortfolioMotion.fast,
              style: PortfolioType.display(24, height: 1.2, letterSpacing: 0, color: hovered ? c.accent : c.ink),
              child: Text(p.headline ?? p.title),
            ),
            const SizedBox(height: 16),
            Text(p.description, style: PortfolioType.body(color: c.inkMuted)),
            const SizedBox(height: 16),
            TagWrap(p.techStack),
            if (links.isNotEmpty) ...[
              const Spacer(),
              const SizedBox(height: 12),
              Wrap(spacing: 20, runSpacing: 4, children: links),
            ],
          ],
        ),
      ),
    );
  }
}

class _MoreProjectRow extends StatelessWidget {
  const _MoreProjectRow({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final p = project;
    final titleStyle = PortfolioType.body(weight: FontWeight.w700, color: c.ink);
    return Hoverable(
      builder: (context, hovered) => AnimatedContainer(
        duration: PortfolioMotion.medium,
        curve: PortfolioMotion.ease,
        padding: EdgeInsets.only(top: 18, bottom: 18, right: 24, left: hovered && !context.reduceMotion ? 8 : 0),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: hovered ? c.accent : c.line)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            p.liveLink.isNotEmpty
                ? PortfolioLink(label: p.title, url: p.liveLink, style: titleStyle)
                : Text(p.title, style: titleStyle),
            const SizedBox(height: 2),
            Text(p.description, style: PortfolioType.body(size: 15, color: c.inkMuted)),
          ],
        ),
      ),
    );
  }
}
