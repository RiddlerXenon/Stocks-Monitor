import 'dart:convert';
import 'package:flutter/foundation.dart';

class ParseStocksprice {
  static parseStocksPrice(String responseBody) {
    try {
      final parsed = stPrFromJson(responseBody);
      return parsed.data[0].p;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }
}

StocksPrice stPrFromJson(String str) => StocksPrice.fromJson(json.decode(str));

class StocksPrice {
  List<Datum> data;

  StocksPrice({
    required this.data,
  });

  factory StocksPrice.fromJson(Map<String, dynamic> json) => StocksPrice(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  double p;

  Datum({
    required this.p,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        p: json["p"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "p": p,
      };
}
