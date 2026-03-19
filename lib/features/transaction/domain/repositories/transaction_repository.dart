import '../entities/transaction_entity.dart';
import '../entities/transaction_status.dart';

/// Repository interface for transaction operations.
///
/// Domain layer — implementation in data layer (Supabase).
abstract class TransactionRepository {
  /// Create a new transaction for a listing purchase.
  Future<TransactionEntity> createTransaction({
    required String listingId,
    required String buyerId,
    required String sellerId,
    required int itemAmountCents,
    required int shippingCostCents,
  });

  /// Get a transaction by ID.
  Future<TransactionEntity?> getTransaction(String id);

  /// Get all transactions for a user (as buyer or seller).
  Future<List<TransactionEntity>> getTransactionsForUser(String userId);

  /// Update transaction status with validation.
  ///
  /// Throws [InvalidTransitionException] if the transition is not allowed.
  Future<TransactionEntity> updateStatus({
    required String transactionId,
    required TransactionStatus newStatus,
  });

  /// Set the Mollie payment ID after payment creation.
  Future<TransactionEntity> setMolliePaymentId({
    required String transactionId,
    required String molliePaymentId,
  });

  /// Set the escrow deadline (48h after delivery).
  Future<TransactionEntity> setEscrowDeadline({
    required String transactionId,
    required DateTime deadline,
  });
}

/// Thrown when a status transition violates the state machine.
class InvalidTransitionException implements Exception {
  const InvalidTransitionException({
    required this.currentStatus,
    required this.attemptedStatus,
  });

  final TransactionStatus currentStatus;
  final TransactionStatus attemptedStatus;

  @override
  String toString() =>
      'InvalidTransitionException: '
      'Cannot transition from $currentStatus to $attemptedStatus';
}
