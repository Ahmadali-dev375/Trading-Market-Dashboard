import 'package:http/http.dart' as http;
import '../Model/coin.dart';

class CoinGeckoService {
  static const String _baseUrl = 'https://api.coingecko.com/api/v3';
  static DateTime? _lastRequestTime;

  /// Fetches cryptocurrency market data including 7-day sparkline history.
  /// Enforces a client-side throttle to respect CoinGecko free API limits.
  static Future<List<CoinModel>?> getCoinMarkets({bool forceRefresh = false}) async {
    const String endpoint =
        '$_baseUrl/coins/markets?vs_currency=usd&sparkline=true';

    final now = DateTime.now();
    if (!forceRefresh &&
        _lastRequestTime != null &&
        now.difference(_lastRequestTime!).inSeconds < 10) {
      // Cooldown to avoid hitting 429 rate limit
      return null;
    }

    try {
      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      _lastRequestTime = DateTime.now();

      if (response.statusCode == 200) {
        return coinModelFromJson(response.body);
      } else {
        // Return null or throw depending on caller handling
        return null;
      }
    } catch (_) {
      return null;
    }
  }
}
