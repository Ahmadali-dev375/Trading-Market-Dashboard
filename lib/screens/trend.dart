// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../Components/Item.dart';
import '../Model/coin.dart';
import '../services/coingecko_service.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  bool isRefreshing = true;
  List<CoinModel>? coinMarket = [];

  @override
  void initState() {
    super.initState();
    fetchMarketData();
  }

  Future<void> fetchMarketData({bool forceRefresh = false}) async {
    setState(() {
      isRefreshing = true;
    });

    final data = await CoinGeckoService.getCoinMarkets(forceRefresh: forceRefresh);

    if (mounted) {
      setState(() {
        if (data != null && data.isNotEmpty) {
          coinMarket = data;
        }
        isRefreshing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          shadowColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Trending",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(size: 30, color: Colors.white),
        ),
        body: RefreshIndicator(
          onRefresh: () => fetchMarketData(forceRefresh: true),
          child: Column(
            children: [
              if (isRefreshing)
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0xffFBC700),
                    ),
                  ),
                )
              else if (coinMarket == null || coinMarket!.isEmpty)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(myHeight * 0.06),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_off, size: 48, color: Colors.amber),
                          SizedBox(height: 16),
                          Text(
                            'CoinGecko rate limit reached or network unavailable.\nPlease wait a moment and pull down to refresh.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: coinMarket!.length,
                    itemBuilder: (context, index) {
                      return Item(
                        item: coinMarket![index],
                        demoQuantity: (index + 1) * 0.75,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
