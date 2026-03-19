import 'package:flutter/material.dart';

import '../../core/design_system/colors.dart';

/// Step circle for [EscrowTimeline] — complete, active, or pending.
class EscrowStepCircle extends StatelessWidget {
  const EscrowStepCircle({
    required this.isComplete,
    required this.isActive,
    super.key,
  });

  final bool isComplete;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    if (isComplete) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: DeelmarktColors.trustEscrow,
        ),
        child: const Icon(Icons.check, size: 14, color: DeelmarktColors.white),
      );
    }

    if (isActive) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: DeelmarktColors.primary.withValues(alpha: 0.15),
          border: Border.all(color: DeelmarktColors.primary, width: 2),
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: DeelmarktColors.primary,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: DeelmarktColors.neutral300, width: 2),
      ),
    );
  }
}

/// Connector line between steps — solid (complete) or dashed (pending).
class EscrowConnectorPainter extends CustomPainter {
  const EscrowConnectorPainter({
    required this.isComplete,
    required this.completeColor,
    required this.pendingColor,
  });

  final bool isComplete;
  final Color completeColor;
  final Color pendingColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = isComplete ? completeColor : pendingColor
          ..strokeWidth = 2
          ..style = isComplete ? PaintingStyle.fill : PaintingStyle.stroke;

    if (isComplete) {
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
    } else {
      const dashWidth = 4.0;
      const dashGap = 3.0;
      var x = 0.0;
      while (x < size.width) {
        canvas.drawLine(
          Offset(x, size.height / 2),
          Offset(x + dashWidth, size.height / 2),
          paint,
        );
        x += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant EscrowConnectorPainter oldDelegate) =>
      isComplete != oldDelegate.isComplete;
}
