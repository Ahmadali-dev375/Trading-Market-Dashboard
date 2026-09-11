class ChartModel {
  final int time;
  final double? open;
  final double? high;
  final double? low;
  final double? close;

  ChartModel({
    required this.time,
    this.open,
    this.high,
    this.low,
    this.close,
  });

  factory ChartModel.fromJson(List<dynamic> l) {
    return ChartModel(
      time: (l[0] as num?)?.toInt() ?? 0,
      open: (l[1] as num?)?.toDouble(),
      high: (l[2] as num?)?.toDouble(),
      low: (l[3] as num?)?.toDouble(),
      close: (l[4] as num?)?.toDouble(),
    );
  }
}
