import 'package:flutter/material.dart';
import 'package:zamir_professional_portfolio/core/site_config.dart';
import 'package:zamir_professional_portfolio/core/theme/app_theme.dart';
import 'common.dart';

/// "04 — Contact" contrast band with the footer.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    const email = SiteConfig.contactEmail;
    Widget step(int i, Widget child) => Reveal(delay: Duration(milliseconds: 90 * i), child: child);

    return ColoredBox(
      color: c.band,
      child: ContentWidth(
        padding: const EdgeInsets.symmetric(vertical: 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            step(0, Text('04 — Contact', style: PortfolioType.mono(color: c.bandAccent))),
            const SizedBox(height: 28),
            step(
              1,
              Semantics(
                header: true,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 14 * 72),
                  child: Text(
                    'Need a Flutter app that handles real money?',
                    style: PortfolioType.display(
                      PortfolioType.fluid(context, min: 36, max: 72, vw: 0.06),
                      color: c.onBand,
                      height: 1.02,
                      letterSpacing: -0.03,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            step(
              2,
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 34 * 19),
                child: Text(
                  "I take on full-time remote roles and freelance builds. Tell me what you're making and I'll reply within a day.",
                  style: PortfolioType.body(size: 19, color: c.onBandMuted),
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
                  PortfolioButton(
                    label: email,
                    semanticLabel: 'Email $email',
                    background: c.bandAccent,
                    foreground: c.onBandAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    onPressed: () => openUrl('mailto:$email'),
                  ),
                  PortfolioButton(
                    label: 'GitHub ↗',
                    semanticLabel: 'GitHub profile',
                    variant: ButtonVariant.outlined,
                    foreground: c.onBand,
                    borderColor: c.onBandLine,
                    weight: FontWeight.w500,
                    onPressed: () => openUrl(SiteConfig.githubUrl),
                  ),
                  PortfolioButton(
                    label: 'LinkedIn ↗',
                    semanticLabel: 'LinkedIn profile',
                    variant: ButtonVariant.outlined,
                    foreground: c.onBand,
                    borderColor: c.onBandLine,
                    weight: FontWeight.w500,
                    onPressed: () => openUrl(SiteConfig.linkedInUrl),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 76),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: c.onBandDivider))),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12,
                runSpacing: 12,
                children: [
                  Text('© 2026 ${SiteConfig.name} · Lahore, Pakistan', style: PortfolioType.body(size: 14, color: c.onBandFaint)),
                  Text('Built with Flutter', style: PortfolioType.body(size: 14, color: c.onBandFaint)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
