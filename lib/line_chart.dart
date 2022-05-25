import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/geting_data/get_candles.dart';
import 'package:flutter_application_1/geting_data/get_max_min.dart';
import 'package:http/http.dart' as http;

class LineChartWidget {
  static getLineChart(symbol) {
    var now = DateTime.now();
    int _now = (now.millisecondsSinceEpoch / 1000).round();
    int _yago = (_now - 31556926).round();

    Ijf i = Ijf();

    return FutureBuilder<List>(
      future: i.fetchCandles(http.Client(), symbol, _now, _yago),
      builder: (context, snapshot3) {
        if (snapshot3.hasData) {
          if (snapshot3.data?[0] != false) {
            List allVal = MaxMinGet.getMaxMin(
              snapshot3.data,
            );

            return Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: const Text(
                  'Graph for the last year',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 250,
                child: Container(
                    margin: const EdgeInsets.all(12),
                    child: LineChart(LineChartData(
                        backgroundColor: Colors.black38,
                        borderData: FlBorderData(
                            border: Border.all(color: Colors.white24)),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                              dotData: FlDotData(show: false),
                              spots: spotsCreater(snapshot3.data))
                        ],
                        minX: allVal[0],
                        maxX: allVal[1],
                        minY: allVal[2],
                        maxY: allVal[3]))),
              )
            ]);
          } else {
            return Column(children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: const Text(
                  'Graph for the last year\n',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            ]);
          }
        } else {
          return Column(children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: const Text(
                'Graph for the last year\n',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          ]);
        }
      },
    );
  }

  static spotsCreater(snapshotData) {
    List<FlSpot> spots = [];

    for (var i = 0; i < snapshotData[0].length; i++) {
      spots.add(FlSpot(snapshotData[1][i].toDouble(), snapshotData[0][i]));
    }

    return spots;
  }
}
