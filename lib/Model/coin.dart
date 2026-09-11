import 'dart:convert';

List<CoinModel> coinModelFromJson(String str) =>
    List<CoinModel>.from(json.decode(str).map((x) => CoinModel.fromJson(x)));

String coinModelToJson(List<CoinModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoinModel {
  CoinModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCapRank,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.marketCapChangePercentage24H,
    required this.sparklineIn7D,
  });

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final int marketCapRank;
  final double totalVolume;
  final double high24H;
  final double low24H;
  final double priceChange24H;
  final double marketCapChangePercentage24H;
  final SparklineIn7D sparklineIn7D;

  factory CoinModel.fromJson(Map<String, dynamic> json) => CoinModel(
        id: json["id"] ?? '',
        symbol: json["symbol"] ?? '',
        name: json["name"] ?? '',
        image: json["image"] ?? '',
        currentPrice: (json["current_price"] as num?)?.toDouble() ?? 0.0,
        marketCapRank: (json["market_cap_rank"] as num?)?.toInt() ?? 0,
        totalVolume: (json["total_volume"] as num?)?.toDouble() ?? 0.0,
        high24H: (json["high_24h"] as num?)?.toDouble() ?? 0.0,
        low24H: (json["low_24h"] as num?)?.toDouble() ?? 0.0,
        priceChange24H: (json["price_change_24h"] as num?)?.toDouble() ?? 0.0,
        marketCapChangePercentage24H:
            (json["market_cap_change_percentage_24h"] as num?)?.toDouble() ?? 0.0,
        sparklineIn7D: json["sparkline_in_7d"] != null
            ? SparklineIn7D.fromJson(json["sparkline_in_7d"])
            : SparklineIn7D(price: const []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap_rank": marketCapRank,
        "total_volume": totalVolume,
        "high_24h": high24H,
        "low_24h": low24H,
        "price_change_24h": priceChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "sparkline_in_7d": sparklineIn7D.toJson(),
      };
}

class SparklineIn7D {
  SparklineIn7D({
    required this.price,
  });

  final List<double> price;

  factory SparklineIn7D.fromJson(Map<String, dynamic> json) => SparklineIn7D(
        price: json["price"] != null
            ? List<double>.from((json["price"] as List)
                .map((x) => (x as num?)?.toDouble() ?? 0.0))
            : const [],
      );

  Map<String, dynamic> toJson() => {
        "price": List<dynamic>.from(price.map((x) => x)),
      };
}
