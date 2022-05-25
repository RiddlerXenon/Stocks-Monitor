import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/geting_data/get_cur_pr.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Gbf {
  Future<List> fetchStocksList(http.Client client) async {
    final response = await client.get(Uri.parse(
        'https://finnhub.io/api/v1/stock/symbol?exchange=US&token=c8pok02ad3icps1jt07g'));
    return stocksListFromJson(response.body);
  }
}

stocksListFromJson(String str) =>
    List.from(json.decode(str).map((x) => StocksList.fromJson(x)));

class StocksList {
  String description;
  String symbol;

  StocksList({
    required this.description,
    required this.symbol,
  });

  factory StocksList.fromJson(Map<String, dynamic> json) => StocksList(
        description: json["description"],
        symbol: json["symbol"],
      );
}

class GetStoksList {
  static stocksListGet(_channel) {
    Gbf g = Gbf();

    return FutureBuilder<List>(
      future: g.fetchStocksList(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('An error has occurred!'),
          );
        } else if (snapshot.hasData) {
          try {
            var _broadcast = _channel.stream.asBroadcastStream();
            return PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data?.length,
              itemBuilder: (_, index) {
                return GetCurPr.curPrGet(
                    snapshot.data, index, _broadcast, _channel);
              },
            );
          } catch (e) {
            if (kDebugMode) {
              print('Error: $e');
            }
            return const Text('Error!\nTry to restart app!');
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
