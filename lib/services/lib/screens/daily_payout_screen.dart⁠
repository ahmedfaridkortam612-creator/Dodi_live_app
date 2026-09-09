import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../services/wallet_api_service.dart';

class DailyPayoutScreen extends StatefulWidget {
  final WalletApiService walletApi;

  const DailyPayoutScreen({Key? key, required this.walletApi}) : super(key: key);

  @override
  _DailyPayoutScreenState createState() => _DailyPayoutScreenState();
}

class _DailyPayoutScreenState extends State<DailyPayoutScreen> {
  WalletState? _wallet;
  bool _loading = true;
  bool _withdrawing = false;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _loadWallet();
  }

  Future<void> _loadWallet() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      final wallet = await widget.walletApi.fetchWallet();
      setState(() => _wallet = wallet);
    } catch (e) {
      setState(() => _loadError = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _processDailyWithdrawal() async {
    final wallet = _wallet;
    if (wallet == null || _withdrawing) return;

    // These are UX shortcuts only — the server re-checks both and is the
    // real gate. We still surface them locally so the button can be
    // disabled and give instant feedback without a round trip.
    if (!wallet.canWithdrawToday) {
      _showMessage("عذراً، يحق لك السحب مرة واحدة فقط كل 24 ساعة!");
      return;
    }
    if (wallet.hostAmountUSD < wallet.minWithdrawalUSD) {
      _showMessage("الحد الأدنى للسحب اليومي هو \$${wallet.minWithdrawalUSD.toStringAsFixed(2)}");
      return;
    }

    setState(() => _withdrawing = true);
    try {
      final result = await widget.walletApi.requestWithdrawal(idempotencyKey: const Uuid().v4());
      if (!mounted) return;

      if (result.success && result.updatedWallet != null) {
        setState(() => _wallet = result.updatedWallet);
        _showSuccessDialog(result.updatedWallet!.hostAmountUSD);
      } else {
        _showMessage(result.errorMessage ?? "تعذر إتمام عملية السحب، حاول مرة أخرى.");
      }
    } catch (e) {
      _showMessage("حدث خطأ أثناء السحب، يرجى المحاولة لاحقاً.");
    } finally {
      if (mounted) setState(() => _withdrawing = false);
    }
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void _showSuccessDialog(double amountPaidOut) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تم إرسال طلب السحب اليومي 🚀"),
        content: Text(
          "قيمة السحب: \$${amountPaidOut.toStringAsFixed(2)}\nتم تحويل الطلب للجهة المالية وسيتم الإيداع خلال دقائق.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("موافق"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text("محفظة المضيفة والسحب اليومي"),
        backgroundColor: Colors.purple.shade900,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_loadError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.redAccent, size: 40),
              const SizedBox(height: 12),
              Text(
                "تعذر تحميل بيانات المحفظة\n$_loadError",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _loadWallet, child: const Text("إعادة المحاولة")),
            ],
          ),
        ),
      );
    }

    final wallet = _wallet!;
    return RefreshIndicator(
      onRefresh: _loadWallet,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildBalanceCard(wallet),
          const SizedBox(height: 20),
          _buildAdminShareCard(wallet),
          const SizedBox(height: 40),
          _buildWithdrawButton(wallet),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(WalletState wallet) {
    return Card(
      color: Colors.purple.shade800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("إجمالي الكوينز المكتسبة", style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              "${wallet.coinsBalance}",
              style: const TextStyle(color: Colors.amber, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.white24, height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("القيمة الكلية: \$${wallet.totalUSD.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white)),
                Text(
                  "صافي المضيفة (${(wallet.hostShareRatio * 100).toStringAsFixed(0)}%): \$${wallet.hostAmountUSD.toStringAsFixed(2)}",
                  style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAdminShareCard(WalletState wallet) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "عمولة الإدارة المقتطعة (${((1 - wallet.hostShareRatio) * 100).toStringAsFixed(0)}%):",
            style: const TextStyle(color: Colors.white70),
          ),
          Text("\$${wallet.adminAmountUSD.toStringAsFixed(2)}", style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildWithdrawButton(WalletState wallet) {
    final enabled = wallet.canWithdrawToday && !_withdrawing;
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? Colors.green : Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: enabled ? _processDailyWithdrawal : null,
        child: _withdrawing
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
              )
            : Text(
                wallet.canWithdrawToday
                    ? "سحب الأرباح اليومية (\$${wallet.hostAmountUSD.toStringAsFixed(2)})"
                    : "تم السحب اليوم (انتظر 24 ساعة)",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
      ),
    );
  }
}
