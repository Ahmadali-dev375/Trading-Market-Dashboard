// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_interpolation_to_compose_strings, avoid_unnecessary_containers, avoid_print, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Model/chart.dart';
import '../Model/coin.dart';

class SelectedCoin extends StatefulWidget {
  final CoinModel selectItem;
  final double demoQuantity;

  SelectedCoin({required this.selectItem, this.demoQuantity = 1.0});

  @override
  State<SelectedCoin> createState() => _SelectedCoinState();
}

class _SelectedCoinState extends State<SelectedCoin> {
  late TrackballBehavior trackballBehavior;
  List<ChartModel>? itemChart;
  bool isRefresh = true;

  final List<String> timeFilters = ['D', 'W', 'M', '3M', '6M', 'Y'];
  final List<bool> filterSelection = [true, false, false, false, false, false];
  int days = 1;

  @override
  void initState() {
    super.initState();
    getChart();
    trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
  }

  void setDays(String txt) {
    setState(() {
      if (txt == 'D') {
        days = 1;
      } else if (txt == 'W') {
        days = 7;
      } else if (txt == 'M') {
        days = 30;
      } else if (txt == '3M') {
        days = 90;
      } else if (txt == '6M') {
        days = 180;
      } else if (txt == 'Y') {
        days = 365;
      }
    });
  }

  Future<void> getChart() async {
    final String url =
        'https://api.coingecko.com/api/v3/coins/${widget.selectItem.id}/ohlc?vs_currency=usd&days=$days';

    setState(() {
      isRefresh = true;
    });

    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        Iterable x = json.decode(response.body);
        List<ChartModel> modelList =
            x.map((e) => ChartModel.fromJson(e)).toList();
        if (mounted) {
          setState(() {
            itemChart = modelList;
          });
        }
      } else {
        print('OHLC API Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching OHLC chart: $e');
    } finally {
      if (mounted) {
        setState(() {
          isRefresh = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;

    // Real API-derived market cap change percentage (no random noise added)
    double marketCapChange = widget.selectItem.marketCapChangePercentage24H;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a35),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 16, bottom: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: myWidth * 0.05, vertical: myHeight * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: myHeight * 0.09,
                        child: Image.network(
                          widget.selectItem.image,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.monetization_on, color: Colors.white, size: 40),
                        ),
                      ),
                      SizedBox(width: myWidth * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.selectItem.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Demo: ${widget.demoQuantity.toStringAsFixed(2)} ${widget.selectItem.symbol.toUpperCase()}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.selectItem.currentPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${marketCapChange >= 0 ? '+' : ''}${marketCapChange.toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: marketCapChange >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: myHeight * 0.01),
            Center(
              child: Container(
                height: myHeight * 0.045,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: timeFilters.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: myWidth * 0.015),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            for (int i = 0; i < filterSelection.length; i++) {
                              filterSelection[i] = (i == index);
                            }
                          });
                          setDays(timeFilters[index]);
                          getChart();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: myWidth * 0.035,
                              vertical: myHeight * 0.006),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: filterSelection[index]
                                ? const Color.fromARGB(255, 78, 175, 255)
                                : Colors.white12,
                          ),
                          child: Center(
                            child: Text(
                              timeFilters[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: filterSelection[index]
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: myHeight * 0.02),
            Expanded(
              child: Container(
                width: myWidth,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: isRefresh
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color(0xffFBC700),
                        ),
                      )
                    : itemChart == null || itemChart!.isEmpty
                        ? Padding(
                            padding: EdgeInsets.all(myHeight * 0.04),
                            child: Center(
                              child: Text(
                                'CoinGecko free API rate limit reached or market data unavailable. Please wait a moment and try again.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.amber),
                              ),
                            ),
                          )
                        : SfCartesianChart(
                            trackballBehavior: trackballBehavior,
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true,
                              zoomMode: ZoomMode.x,
                            ),
                            primaryXAxis: DateTimeAxis(
                              axisLine: AxisLine(width: 2, color: Colors.white24),
                              majorGridLines: MajorGridLines(width: 0.5, color: Colors.white10),
                              labelStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.blueAccent,
                              ),
                            ),
                            primaryYAxis: NumericAxis(
                              axisLine: AxisLine(width: 2, color: Colors.white24),
                              majorGridLines: MajorGridLines(width: 0.5, color: Colors.white10),
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.blueAccent,
                              ),
                            ),
                            series: <CandleSeries>[
                              CandleSeries<ChartModel, DateTime>(
                                enableSolidCandles: true,
                                enableTooltip: true,
                                bullColor: Colors.green,
                                bearColor: Colors.red,
                                dataSource: itemChart!,
                                xValueMapper: (ChartModel sales, _) =>
                                    DateTime.fromMillisecondsSinceEpoch(sales.time),
                                lowValueMapper: (ChartModel sales, _) =>
                                    sales.low,
                                highValueMapper: (ChartModel sales, _) =>
                                    sales.high,
                                openValueMapper: (ChartModel sales, _) =>
                                    sales.open,
                                closeValueMapper: (ChartModel sales, _) =>
                                    sales.close,
                                animationDuration: 55,
                              ),
                            ],
                          ),
              ),
            ),
            SizedBox(height: myHeight * 0.02),
          ],
        ),
      ),
    );
  }
}
