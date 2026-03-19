import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';
import '../../../../widgets/buttons/buttons.dart';
import '../../../../widgets/trust/escrow_timeline.dart';
import '../../../../widgets/trust/escrow_trust_banner.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/transaction_status.dart';

/// Transaction detail screen — shows escrow timeline, amounts, and actions.
///
/// Reference: docs/design-system/patterns.md §Escrow Timeline
class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({required this.transaction, super.key});

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('transaction.status'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.s4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trust banner
            const EscrowTrustBanner(),
            const SizedBox(height: Spacing.s6),

            // Escrow timeline
            EscrowTimeline(
              currentStatus: transaction.status,
              escrowDeadline: transaction.escrowDeadline,
            ),
            const SizedBox(height: Spacing.s6),

            // Amount summary
            _AmountSection(transaction: transaction),
            const SizedBox(height: Spacing.s6),

            // Action buttons based on status
            _ActionSection(transaction: transaction),
          ],
        ),
      ),
    );
  }
}

class _AmountSection extends StatelessWidget {
  const _AmountSection({required this.transaction});

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.s4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? DeelmarktColors.white,
        borderRadius: BorderRadius.circular(Spacing.s3),
        border: Border.all(color: DeelmarktColors.neutral200),
      ),
      child: Column(
        children: [
          _row(
            context,
            'payment.itemPrice'.tr(),
            _fmt(transaction.itemAmountCents),
          ),
          const SizedBox(height: Spacing.s2),
          _row(
            context,
            'payment.platformFee'.tr(),
            _fmt(transaction.platformFeeCents),
          ),
          const SizedBox(height: Spacing.s2),
          _row(
            context,
            'payment.shippingCost'.tr(),
            _fmt(transaction.shippingCostCents),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: Spacing.s2),
            child: Divider(),
          ),
          _row(
            context,
            'payment.total'.tr(),
            _fmt(transaction.totalAmountCents),
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    String label,
    String amount, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : null,
          ),
        ),
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isBold ? FontWeight.bold : null,
          ),
        ),
      ],
    );
  }

  String _fmt(int cents) {
    final euros = cents / 100;
    return '\u20AC${euros.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}

class _ActionSection extends StatelessWidget {
  const _ActionSection({required this.transaction});

  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return switch (transaction.status) {
      TransactionStatus.delivered => Column(
        children: [
          DeelButton(
            label: 'escrow.confirmDelivery'.tr(),
            leadingIcon: PhosphorIcons.checkCircle(),
            variant: DeelButtonVariant.success,
            onPressed: () {
              // TODO: Wire to ConfirmDeliveryUseCase
            },
          ),
          const SizedBox(height: Spacing.s3),
          DeelButton(
            label: 'escrow.disputeOrder'.tr(),
            leadingIcon: PhosphorIcons.warningCircle(),
            variant: DeelButtonVariant.destructive,
            onPressed: () {
              // TODO: Wire to dispute flow
            },
          ),
        ],
      ),
      TransactionStatus.confirmed || TransactionStatus.released => Padding(
        padding: const EdgeInsets.all(Spacing.s4),
        child: Row(
          children: [
            Icon(
              PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
              color: DeelmarktColors.trustVerified,
            ),
            const SizedBox(width: Spacing.s2),
            Text(
              'escrow.fundsReleased'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: DeelmarktColors.trustVerified,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
