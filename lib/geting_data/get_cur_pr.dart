import 'package:flutter/material.dart';
import 'package:flutter_application_1/box_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Fdg {
  Future<List> fetchStocksCurPr(http.Client client, symbol) async {
    final response = await client.get(Uri.parse(
        'https://finnhub.io/api/v1/quote?symbol=$symbol&token=c8pok02ad3icps1jt07g'));

    final parsed = stocksCurPrFromJson(response.body);

    return [parsed.c, parsed.l, parsed.h];
  }
}

StocksCurPr stocksCurPrFromJson(String str) =>
    StocksCurPr.fromJson(json.decode(str));

class StocksCurPr {
  StocksCurPr({
    required this.c,
    required this.h,
    required this.l,
  });

  double c;
  double h;
  double l;

  factory StocksCurPr.fromJson(Map<String, dynamic> json) => StocksCurPr(
        c: json["c"].toDouble(),
        h: json["h"].toDouble(),
        l: json["l"].toDouble(),
      );
}

class GetCurPr {
  static curPrGet(snapshotData, index, _broadcast, _channel) {
    Fdg f = Fdg();
    return FutureBuilder<List>(
        future: f.fetchStocksCurPr(http.Client(), snapshotData[index].symbol),
        builder: (context, snapshot2) {
          if (snapshot2.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot2.hasData) {
            return ListOfBoxes.boxList(
                snapshotData, snapshot2.data, _broadcast, index, _channel);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
