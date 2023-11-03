import 'package:flutter/widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChart extends StatefulWidget {
  final Map<String, double> dataMap;
  const PieChart({super.key, required this.dataMap});

  @override
  State<PieChart> createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PieChart(dataMap: widget.dataMap),
    );
  }
}
