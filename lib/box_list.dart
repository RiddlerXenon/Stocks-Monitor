import 'package:flutter/material.dart';
import 'package:flutter_application_1/line_chart.dart';
import 'package:flutter_application_1/stream.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListOfBoxes {
  static boxList(snapshotData, snapshotData2, _broadcast, index, _channel) {
    return ListView(physics: const ClampingScrollPhysics(), children: [
      Container(
        padding: const EdgeInsets.all(3),
      ),
      SizedBox(
        width: double.infinity,
        height: 100,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 60, 60, 60),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Stock name:\n${snapshotData[index].description}",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 100,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 60, 60, 60),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Last current price\n${snapshotData2[0]} \$",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 220,
                height: 270,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 60, 60, 60),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "The highest price per day\n${snapshotData2[2]} \$",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: SvgPicture.asset(
                            'assets/images/image_h.svg',
                            color: Colors.green,
                            width: 100,
                          ),
                        ),
                      ]),
                ),
              ),
              SizedBox(
                width: 220,
                height: 270,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 60, 60, 60),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "The lowest price per day\n${snapshotData2[1]} \$",
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: SvgPicture.asset(
                            'assets/images/image_l.svg',
                            color: Colors.red,
                            width: 100,
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 100,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 60, 60, 60),
            borderRadius: BorderRadius.circular(20),
          ),
          child: StreamStocks.streamStocks(
              _broadcast, _channel, snapshotData, index),
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 300,
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 60, 60, 60),
              borderRadius: BorderRadius.circular(20),
            ),
            child: LineChartWidget.getLineChart(snapshotData[index].symbol)),
      ),
    ]);
  }
}
