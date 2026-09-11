// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../Components/bit.dart';
import '../Model/coin.dart';
import '../auth/login.dart';
import '../services/coingecko_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            )
          ],
          elevation: 5,
          shadowColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Explore",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: IconThemeData(size: 30, color: Colors.white),
        ),
        drawer: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(45.0),
              bottomRight: Radius.circular(45.0),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'Disclaimer',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          fontSize: 32,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      textAlign: TextAlign.start,
                      'This application is a portfolio demonstration app designed to showcase Flutter UI, CoinGecko API integration, and interactive financial charts.\n\nIt does NOT execute real trades, manage real money, or connect to brokerage services. Market prices, sparklines, and OHLC data are fetched from the public CoinGecko API. Quantities are simulated demo values.',
                      style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
                      return Bit(
                        item: coinMarket![index],
                        demoQuantity: (index + 1) * 0.5,
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
