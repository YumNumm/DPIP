import "package:dpip/util/extension/build_context.dart";
import "package:flutter/widgets.dart";

class ReportDetailField extends StatelessWidget {
  final String label;
  final Widget child;

  const ReportDetailField({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: context.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }
}
