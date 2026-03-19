import '../entities/payment_entity.dart';
import '../entities/transaction_status.dart';
import '../repositories/payment_repository.dart';
import '../repositories/transaction_repository.dart';

/// Creates a Mollie payment for a transaction and returns the checkout URL.
///
/// Business rules:
/// 1. Transaction must be in `created` status
/// 2. Transitions to `paymentPending`
/// 3. Stores the Mollie payment ID on the transaction
///
/// Reference: docs/epics/E03-payments-escrow.md §Mollie Connect Integration
class CreatePaymentUseCase {
  const CreatePaymentUseCase({
    required this.transactionRepository,
    required this.paymentRepository,
  });

  final TransactionRepository transactionRepository;
  final PaymentRepository paymentRepository;

  /// Returns the [PaymentEntity] with a checkout URL for the buyer.
  ///
  /// Throws [InvalidTransitionException] if the transaction is not in `created` state.
  Future<PaymentEntity> execute({
    required String transactionId,
    required String redirectUrl,
  }) async {
    final transaction = await transactionRepository.getTransaction(
      transactionId,
    );

    if (transaction == null) {
      throw TransactionNotFoundException(transactionId);
    }

    if (!transaction.status.canTransitionTo(TransactionStatus.paymentPending)) {
      throw InvalidTransitionException(
        currentStatus: transaction.status,
        attemptedStatus: TransactionStatus.paymentPending,
      );
    }

    final payment = await paymentRepository.createPayment(
      transactionId: transactionId,
      amountCents: transaction.totalAmountCents,
      currency: transaction.currency,
      description: 'DeelMarkt order $transactionId',
      redirectUrl: redirectUrl,
    );

    await transactionRepository.setMolliePaymentId(
      transactionId: transactionId,
      molliePaymentId: payment.molliePaymentId,
    );

    await transactionRepository.updateStatus(
      transactionId: transactionId,
      newStatus: TransactionStatus.paymentPending,
    );

    return payment;
  }
}

/// Thrown when a transaction cannot be found.
class TransactionNotFoundException implements Exception {
  const TransactionNotFoundException(this.transactionId);
  final String transactionId;

  @override
  String toString() => 'Transaction not found: $transactionId';
}
