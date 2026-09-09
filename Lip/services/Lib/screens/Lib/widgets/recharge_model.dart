import 'package:flutter/material.dart';
import '../services/wallet_api_service.dart';

/// Shows the coin package list and performs a real purchase through
/// [walletApi]. [paymentMethodToken] should come from your payment SDK
/// (Apple Pay / Google Pay / card-on-file token) — never build a price or
/// coin amount on the client and send it to the server as-is; only the
/// packageId is sent, and the server looks up price/coins itself.
Future<void> showRechargeModal(
  BuildContext context, {
  required WalletApiService walletApi,
  required Future<String?> Function(CoinPackage package) getPaymentMethodToken,
  required void Function(WalletState updatedWallet) onPurchaseComplete,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.grey.shade900,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.75,
        child: _RechargeSheet(
          walletApi: walletApi,
          getPaymentMethodToken: getPaymentMethodToken,
          onPurchaseComplete: onPurchaseComplete,
        ),
      );
    },
  );
}

class _RechargeSheet extends StatefulWidget {
  final WalletApiService walletApi;
  final Future<String?> Function(CoinPackage package) getPaymentMethodToken;
  final void Function(WalletState updatedWallet) onPurchaseComplete;

  const _RechargeSheet({
    required this.walletApi,
    required this.getPaymentMethodToken,
    required this.onPurchaseComplete,
  });

  @override
  State<_RechargeSheet> createState() => _RechargeSheetState();
}

class _RechargeSheetState extends State<_RechargeSheet> {
  List<CoinPackage>? _packages;
  String? _loadError;
  String? _purchasingPackageId;

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  Future<void> _loadPackages() async {
    setState(() => _loadError = null);
    try {
      final packages = await widget.walletApi.fetchCoinPackages();
      setState(() => _packages = packages);
    } catch (e) {
      setState(() => _loadError = e.toString());
    }
  }

  Future<void> _buyPackage(CoinPackage pkg) async {
    if (_purchasingPackageId != null) return;

    final token = await widget.getPaymentMethodToken(pkg);
    if (token == null) return; // user cancelled the payment sheet

    setState(() => _purchasingPackageId = pkg.id);
    try {
      final updatedWallet = await widget.walletApi.purchasePackage(pkg.id, paymentMethodToken: token);
      widget.onPurchaseComplete(updatedWallet);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("تعذر إتمام الشحن: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _purchasingPackageId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "متجر شحن Dodi Live",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loadError != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("تعذر تحميل الباقات\n$_loadError", textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _loadPackages, child: const Text("إعادة المحاولة")),
          ],
        ),
      );
    }
    final packages = _packages;
    if (packages == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final pkg = packages[index];
        final isPurchasing = _purchasingPackageId == pkg.id;
        return Card(
          color: Colors.grey.shade800,
          child: ListTile(
            leading: const Icon(Icons.monetization_on, color: Colors.amber, size: 30),
            title: Text(_formatCoins(pkg.coins), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            subtitle: Text("\$${pkg.priceUSD.toStringAsFixed(2)} USD", style: const TextStyle(color: Colors.greenAccent)),
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber.shade700),
              onPressed: _purchasingPackageId == null ? () => _buyPackage(pkg) : null,
              child: isPurchasing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                    )
                  : const Text("شحن", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
        );
      },
    );
  }

  String _formatCoins(int coins) {
    final withCommas = coins.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return "$withCommas Coins";
  }
}
