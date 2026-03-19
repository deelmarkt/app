import '../entities/ledger_entry.dart';
import '../entities/transaction_status.dart';
import '../repositories/ledger_repository.dart';
import '../repositories/transaction_repository.dart';

/// Confirms delivery and initiates escrow release.
///
/// Business rules:
/// 1. Transaction must be in `delivered` status
/// 2. Transitions to `confirmed`
/// 3. Records ledger entries: escrow → seller + escrow → platform
///
/// Reference: docs/epics/E03-payments-escrow.md
class ConfirmDeliveryUseCase {
  const ConfirmDeliveryUseCase({
    required this.transactionRepository,
    required this.ledgerRepository,
  });

  final TransactionRepository transactionRepository;
  final LedgerRepository ledgerRepository;

  Future<void> execute({
    required String transactionId,
    required String sellerId,
  }) async {
    final transaction = await transactionRepository.getTransaction(
      transactionId,
    );

    if (transaction == null) {
      throw Exception('Transaction not found: $transactionId');
    }

    if (!transaction.status.canTransitionTo(TransactionStatus.confirmed)) {
      throw InvalidTransitionException(
        currentStatus: transaction.status,
        attemptedStatus: TransactionStatus.confirmed,
      );
    }

    // Record seller payout: escrow → seller
    await ledgerRepository.recordEntry(
      transactionId: transactionId,
      idempotencyKey: 'release:seller:$transactionId',
      debitAccount: LedgerAccounts.escrow(transactionId),
      creditAccount: LedgerAccounts.seller(sellerId),
      amountCents: transaction.sellerPayoutCents,
    );

    // Record platform commission: escrow → platform
    await ledgerRepository.recordEntry(
      transactionId: transactionId,
      idempotencyKey: 'release:platform:$transactionId',
      debitAccount: LedgerAccounts.escrow(transactionId),
      creditAccount: LedgerAccounts.platform,
      amountCents: transaction.platformFeeCents,
    );

    await transactionRepository.updateStatus(
      transactionId: transactionId,
      newStatus: TransactionStatus.confirmed,
    );
  }
}
