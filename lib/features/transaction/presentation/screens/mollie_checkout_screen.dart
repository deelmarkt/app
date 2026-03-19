import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/design_system/colors.dart';
import '../../../../core/design_system/spacing.dart';

/// WebView screen for completing Mollie payment (iDEAL checkout).
///
/// Opens the Mollie checkout URL in an in-app WebView.
/// Monitors URL changes to detect redirect back to app.
///
/// Reference: docs/epics/E03-payments-escrow.md §WebView integration
class MollieCheckoutScreen extends StatefulWidget {
  const MollieCheckoutScreen({
    required this.checkoutUrl,
    required this.redirectUrl,
    super.key,
  });

  /// Mollie checkout URL (from PaymentEntity.checkoutUrl).
  final String checkoutUrl;

  /// Our redirect URL — when WebView navigates here, payment is done.
  final String redirectUrl;

  @override
  State<MollieCheckoutScreen> createState() => _MollieCheckoutScreenState();
}

class _MollieCheckoutScreenState extends State<MollieCheckoutScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) {
                if (mounted) setState(() => _isLoading = true);
              },
              onPageFinished: (_) {
                if (mounted) setState(() => _isLoading = false);
              },
              onNavigationRequest: (request) {
                if (request.url.startsWith(widget.redirectUrl)) {
                  _handlePaymentComplete(request.url);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  void _handlePaymentComplete(String redirectedUrl) {
    if (!mounted) return;
    Navigator.of(context).pop(MollieCheckoutResult.completed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('payment.payWithIdeal'.tr()),
        leading: IconButton(
          icon: Icon(PhosphorIcons.x()),
          onPressed:
              () => Navigator.of(context).pop(MollieCheckoutResult.cancelled),
          tooltip: 'action.cancel'.tr(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: DeelmarktColors.white.withValues(alpha: 0.8),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator.adaptive(),
                    const SizedBox(height: Spacing.s4),
                    Text(
                      'payment.processing'.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Result of the Mollie checkout WebView.
enum MollieCheckoutResult {
  /// Buyer completed the payment flow (redirected back).
  completed,

  /// Buyer closed the WebView without completing.
  cancelled,
}
