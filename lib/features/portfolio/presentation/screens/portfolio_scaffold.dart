import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zamir_professional_portfolio/core/responsive_config.dart';
import 'package:zamir_professional_portfolio/core/site_config.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';
import 'package:zamir_professional_portfolio/core/theme/theme_provider.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/providers/portfolio_providers.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/common.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/contact_section.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/experience_timeline.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/hero_section.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/project_grid.dart';
import 'package:zamir_professional_portfolio/features/portfolio/presentation/widgets/skills_section.dart';
import 'package:zamir_professional_portfolio/features/resume/presentation/providers/resume_provider.dart';

class PortfolioScaffold extends ConsumerStatefulWidget {
  const PortfolioScaffold({super.key});

  @override
  ConsumerState<PortfolioScaffold> createState() => _PortfolioScaffoldState();
}

class _PortfolioScaffoldState extends ConsumerState<PortfolioScaffold> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: context.reduceMotion ? Duration.zero : const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  void _downloadCv() {
    final asset = ref.read(resumeProvider).assetPath;
    // Flutter web serves bundled assets under `assets/<asset path>`, relative
    // to the base href, so this works under /portfolio/ too.
    openUrl(kIsWeb ? 'assets/$asset' : asset);
  }

  void _toggleTheme() => ref.read(themeModeNotifierProvider.notifier).toggle(Theme.of(context).brightness);

  List<(String, GlobalKey)> get _navItems => [
        ('Work', _workKey),
        ('Experience', _experienceKey),
        ('Stack', _stackKey),
      ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveConfig.isMobile(context);

    return Scaffold(
      backgroundColor: context.colors.ground,
      drawer: isMobile ? _buildDrawer() : null,
      body: SelectionArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TopNav(
                isMobile: isMobile,
                items: _navItems,
                onNavigate: _scrollTo,
                onHire: () => _scrollTo(_contactKey),
                onToggleTheme: _toggleTheme,
                onSync: kDebugMode ? () => ref.read(dataServiceProvider).seedFirestore() : null,
              ),
              HeroSection(onSeeWork: () => _scrollTo(_workKey), onDownloadCv: _downloadCv),
              const PlatformStrip(),
              ProjectGrid(key: _workKey),
              ExperienceTimeline(key: _experienceKey),
              SkillsSection(key: _stackKey),
              ContactSection(key: _contactKey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Builder(builder: (context) {
      final c = context.colors;
      return Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 12, 12),
                child: Row(
                  children: [
                    Expanded(child: Text(SiteConfig.name, style: PortfolioType.display(18, letterSpacing: -0.01, height: 1.3, color: c.ink))),
                    ThemeToggleButton(onToggle: _toggleTheme),
                  ],
                ),
              ),
              Divider(height: 1, color: c.line),
              for (final (i, (label, key)) in [..._navItems, ('Contact', _contactKey)].indexed)
                _DrawerItem(
                  index: i,
                  label: label,
                  onTap: () {
                    Navigator.of(context).pop();
                    _scrollTo(key);
                  },
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    PortfolioButton(
                      label: 'GitHub ↗',
                      semanticLabel: 'GitHub profile',
                      variant: ButtonVariant.outlined,
                      borderColor: c.line,
                      weight: FontWeight.w500,
                      onPressed: () => openUrl(SiteConfig.githubUrl),
                    ),
                    PortfolioButton(
                      label: 'LinkedIn ↗',
                      semanticLabel: 'LinkedIn profile',
                      variant: ButtonVariant.outlined,
                      borderColor: c.line,
                      weight: FontWeight.w500,
                      onPressed: () => openUrl(SiteConfig.linkedInUrl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

/// Drawer row that slides in after the ones above it.
class _DrawerItem extends StatelessWidget {
  const _DrawerItem({required this.index, required this.label, required this.onTap});

  final int index;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final row = InkWell(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 52),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: c.line))),
        child: Row(
          children: [
            Text('0${index + 1}', style: PortfolioType.mono(size: 12, color: c.accentText)),
            const SizedBox(width: 16),
            Text(label, style: PortfolioType.body(size: 17, weight: FontWeight.w500, color: c.ink)),
          ],
        ),
      ),
    );
    if (context.reduceMotion) return row;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 260 + 60 * index),
      curve: PortfolioMotion.ease,
      child: row,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(offset: Offset(-16 * (1 - t), 0), child: child),
      ),
    );
  }
}

class _TopNav extends StatelessWidget {
  const _TopNav({
    required this.isMobile,
    required this.items,
    required this.onNavigate,
    required this.onHire,
    required this.onToggleTheme,
    this.onSync,
  });

  final bool isMobile;
  final List<(String, GlobalKey)> items;
  final void Function(GlobalKey) onNavigate;
  final VoidCallback onHire;
  final VoidCallback onToggleTheme;
  final VoidCallback? onSync;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final brand = Text(SiteConfig.name, style: PortfolioType.display(18, letterSpacing: -0.01, height: 1.3, color: c.ink));

    final syncButton = onSync == null
        ? null
        : IconButton(
            tooltip: 'Sync Firestore from JSON (debug only)',
            icon: Icon(Icons.sync, size: 20, color: c.inkSubtle),
            onPressed: onSync,
          );
    final toggle = ThemeToggleButton(onToggle: onToggleTheme);

    return Reveal(
      onLoad: true,
      offset: -12,
      child: DecoratedBox(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: c.line))),
        child: Semantics(
          container: true,
          label: 'Main navigation',
          child: ContentWidth(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              children: [
                if (isMobile) ...[
                  Expanded(child: brand),
                  if (syncButton != null) syncButton,
                  toggle,
                  Builder(
                    builder: (context) => IconButton(
                      tooltip: 'Open menu',
                      iconSize: 26,
                      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                      icon: Icon(Icons.menu, color: c.ink),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  ),
                ] else ...[
                  brand,
                  const SizedBox(width: 16),
                  Expanded(
                    // Wraps onto a second line rather than overflowing, like the
                    // reference's flex-wrap.
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 28,
                      runSpacing: 8,
                      children: [
                        if (syncButton != null) syncButton,
                        for (final (label, key) in items) _NavLink(label: label, onTap: () => onNavigate(key)),
                        Wrap(
                          spacing: 4,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            _NavLink(label: 'GitHub ↗', semanticLabel: 'GitHub profile', mono: true, onTap: () => openUrl(SiteConfig.githubUrl)),
                            const SizedBox(width: 12),
                            _NavLink(label: 'LinkedIn ↗', semanticLabel: 'LinkedIn profile', mono: true, onTap: () => openUrl(SiteConfig.linkedInUrl)),
                            const SizedBox(width: 4),
                            toggle,
                          ],
                        ),
                        PortfolioButton(
                          label: 'Hire me',
                          onPressed: onHire,
                          background: c.ink,
                          foreground: c.ground,
                          weight: FontWeight.w500,
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Nav text link with an accent underline that grows in on hover.
class _NavLink extends StatelessWidget {
  const _NavLink({required this.label, required this.onTap, this.semanticLabel, this.mono = false});

  final String label;
  final VoidCallback onTap;
  final String? semanticLabel;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      child: Hoverable(
        cursor: SystemMouseCursors.click,
        builder: (context, hovered) {
          final color = hovered ? c.accent : (mono ? c.inkMuted : c.ink);
          final style = mono ? PortfolioType.mono(size: 13, color: color) : PortfolioType.body(size: 15, color: color);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTap,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: PortfolioLayout.minTap),
              child: Align(
                widthFactor: 1,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedDefaultTextStyle(duration: PortfolioMotion.fast, style: style, child: Text(label)),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: -4,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedFractionallySizedBox(
                          duration: context.reduceMotion ? Duration.zero : PortfolioMotion.medium,
                          curve: PortfolioMotion.ease,
                          widthFactor: hovered ? 1 : 0,
                          child: Container(height: 2, color: c.accent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
