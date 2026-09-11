// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, file_names

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

import '../Model/coin.dart';
import '../screens/coin_detail.dart';

class Item extends StatelessWidget {
  final CoinModel item;
  final double demoQuantity;

  const Item({
    super.key,
    required this.item,
    this.demoQuantity = 1.0,
    double? randomValue,
  });

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    // Honest API-derived 24h market percentage change (no random noise)
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
        elevation: 6,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: myHeight * 0.055,
                width: myHeight * 0.055,
                child: Image.network(
                  item.image,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.monetization_on, color: Colors.white, size: 30),
                ),
              ),
              SizedBox(width: myWidth * 0.03),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Demo: ${demoQuantity.toStringAsFixed(2)} ${item.symbol.toUpperCase()}',
                      style: TextStyle(
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
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
              SizedBox(width: myWidth * 0.03),
              Flexible(
                flex: 3,
                child: Container(
                  height: myHeight * 0.045,
                  child: Sparkline(
                    data: item.sparklineIn7D.price,
                    lineWidth: 1.8,
                    lineColor: isPositive ? Colors.green : Colors.red,
                    fillMode: FillMode.below,
                    fillGradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.7],
                      colors: isPositive
                          ? [Colors.green.withValues(alpha: 0.4), Colors.transparent]
                          : [Colors.red.withValues(alpha: 0.4), Colors.transparent],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
