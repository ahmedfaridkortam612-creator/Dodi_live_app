import 'dart:convert';
import 'package:http/http.dart' as http;

/// Server-returned wallet snapshot. Every field here comes from the backend —
/// the client never computes or stores balance/cooldown state itself.
class WalletState {
  final int coinsBalance;
  final double hostShareRatio; // e.g. 0.50, sent by server so it can change without an app release
  final double coinsPerDollar;
  final double minWithdrawalUSD;
  final bool canWithdrawToday;
  final DateTime? nextWithdrawalAvailableAt;

  WalletState({
    required this.coinsBalance,
    required this.hostShareRatio,
    required this.coinsPerDollar,
    required this.minWithdrawalUSD,
    required this.canWithdrawToday,
    required this.nextWithdrawalAvailableAt,
  });

  factory WalletState.fromJson(Map<String, dynamic> json) {
    return WalletState(
      coinsBalance: json['coinsBalance'] as int,
      hostShareRatio: (json['hostShareRatio'] as num).toDouble(),
      coinsPerDollar: (json['coinsPerDollar'] as num).toDouble(),
      minWithdrawalUSD: (json['minWithdrawalUSD'] as num).toDouble(),
      canWithdrawToday: json['canWithdrawToday'] as bool,
      nextWithdrawalAvailableAt: json['nextWithdrawalAvailableAt'] != null
          ? DateTime.parse(json['nextWithdrawalAvailableAt'] as String)
          : null,
    );
  }

  double get totalUSD => coinsBalance / coinsPerDollar;
  double get hostAmountUSD => totalUSD * hostShareRatio;
  double get adminAmountUSD => totalUSD * (1 - hostShareRatio);
}

class CoinPackage {
  final String id; // server-defined SKU, not a client-computed price
  final double priceUSD;
  final int coins;

  CoinPackage({required this.id, required this.priceUSD, required this.coins});

  factory CoinPackage.fromJson(Map<String, dynamic> json) {
    return CoinPackage(
      id: json['id'] as String,
      priceUSD: (json['priceUSD'] as num).toDouble(),
      coins: json['coins'] as int,
    );
  }
}

class WithdrawalResult {
  final bool success;
  final String? errorMessage;
  final WalletState? updatedWallet;

  WithdrawalResult({required this.success, this.errorMessage, this.updatedWallet});
}

class WalletApiException implements Exception {
  final String message;
  WalletApiException(this.message);
  @override
  String toString() => message;
}

/// All money-moving operations go through here. Nothing in the UI layer
/// should compute a balance, a cooldown, or a payout amount on its own.
class WalletApiService {
  final String baseUrl;
  final Future<String> Function() getAuthToken;

  WalletApiService({required this.baseUrl, required this.getAuthToken});

  Future<Map<String, String>> _headers() async {
    final token = await getAuthToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  /// GET /api/wallet — current balance, live payout ratios, and whether
  /// today's withdrawal window is open. Always the source of truth.
  Future<WalletState> fetchWallet() async {
    final res = await http.get(Uri.parse('$baseUrl/api/wallet'), headers: await _headers());
    if (res.statusCode != 200) {
      throw WalletApiException('Failed to load wallet (${res.statusCode})');
    }
    return WalletState.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  /// GET /api/wallet/packages — coin packages available for purchase.
  Future<List<CoinPackage>> fetchCoinPackages() async {
    final res = await http.get(Uri.parse('$baseUrl/api/wallet/packages'), headers: await _headers());
    if (res.statusCode != 200) {
      throw WalletApiException('Failed to load packages (${res.statusCode})');
    }
    final list = jsonDecode(res.body) as List<dynamic>;
    return list.map((e) => CoinPackage.fromJson(e as Map<String, dynamic>)).toList();
  }

  /// POST /api/wallet/purchase — hands off to the payment provider server-side
  /// and returns the updated wallet once the purchase is confirmed.
  Future<WalletState> purchasePackage(String packageId, {required String paymentMethodToken}) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/wallet/purchase'),
      headers: await _headers(),
      body: jsonEncode({'packageId': packageId, 'paymentMethodToken': paymentMethodToken}),
    );
    if (res.statusCode != 200) {
      final body = _tryDecode(res.body);
      throw WalletApiException(body?['message'] as String? ?? 'Purchase failed (${res.statusCode})');
    }
    return WalletState.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  /// POST /api/wallet/withdraw — server re-validates cooldown, minimum, and
  /// balance, then deducts coins and queues the payout. Idempotency key
  /// prevents a double-tap or retry from creating two payouts.
  Future<WithdrawalResult> requestWithdrawal({required String idempotencyKey}) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/wallet/withdraw'),
      headers: await _headers(),
      body: jsonEncode({'idempotencyKey': idempotencyKey}),
    );
    final body = _tryDecode(res.body);
    if (res.statusCode == 200) {
      return WithdrawalResult(
        success: true,
        updatedWallet: WalletState.fromJson(body as Map<String, dynamic>),
      );
    }
    return WithdrawalResult(
      success: false,
      errorMessage: body?['message'] as String? ?? 'Withdrawal failed (${res.statusCode})',
    );
  }

  Map<String, dynamic>? _tryDecode(String body) {
    try {
      return jsonDecode(body) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
