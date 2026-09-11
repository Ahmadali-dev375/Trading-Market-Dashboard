import 'package:flutter/material.dart';
import '../Model/coin.dart';
import '../screens/coin_detail.dart';

class Bit extends StatelessWidget {
  final CoinModel item;
  final double demoQuantity;

  const Bit({
    super.key,
    required this.item,
    this.demoQuantity = 1.0,
    double? randomValue,
  });

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    // Honest API percentage change (no random noise added)
    double marketCapChange = item.marketCapChangePercentage24H;
    bool isPositive = marketCapChange >= 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectedCoin(
              selectItem: item,
              demoQuantity: demoQuantity,
            ),
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: myHeight * 0.045,
                  width: myHeight * 0.045,
                  child: Image.network(
                    item.image,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.monetization_on, color: Colors.white, size: 28),
                  ),
                ),
              ),
              SizedBox(width: myWidth * 0.02),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Demo: ${demoQuantity.toStringAsFixed(2)} ${item.symbol.toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${item.currentPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${isPositive ? '+' : ''}${marketCapChange.toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: isPositive ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
