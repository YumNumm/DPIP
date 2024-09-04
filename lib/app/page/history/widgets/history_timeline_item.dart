import 'package:dpip/model/history.dart';
import 'package:dpip/util/extension/build_context.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class HistoryTimelineItem extends StatelessWidget {
  final History history;
  final bool first;
  final bool last;

  const HistoryTimelineItem({
    super.key,
    required this.history,
    this.first = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: first ? 42 : 0,
                    bottom: last ? null : 0,
                    height: last ? 42 : null,
                    width: 1,
                    child: Container(
                      color: context.colors.outlineVariant,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colors.primaryContainer,
                      ),
                      child: const Icon(Symbols.rainy_rounded),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 8, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      history.text.content["all"]!.title,
                      style: context.theme.textTheme.labelMedium?.copyWith(color: context.colors.secondary),
                    ),
                    Text(
                      history.text.content["all"]!.subtitle,
                      style: context.theme.textTheme.titleMedium,
                    ),
                    Text(
                      history.text.description["all"]!,
                      style: context.theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
