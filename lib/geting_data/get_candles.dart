import 'dart:convert';
import 'package:http/http.dart' as http;

class Ijf {
  Future<List> fetchCandles(http.Client client, symbol, uniow, unigo) async {
    final response = await client.get(Uri.parse(
        'https://finnhub.io/api/v1/stock/candle?symbol=$symbol&resolution=D&from=$unigo&to=$uniow&token=c8pok02ad3icps1jt07g'));

    if (response.body.toString() == '{"s":"no_data"}') {
      return [false];
    } else {
      final parsed = candlesFromJson(response.body);

      return [parsed.c, parsed.t];
    }
  }
}

StocksCandles candlesFromJson(String str) =>
    StocksCandles.fromJson(json.decode(str));

class StocksCandles {
  List<double> c;
  List<int> t;

  StocksCandles({
    required this.c,
    required this.t,
  });

  factory StocksCandles.fromJson(Map<String, dynamic> json) => StocksCandles(
        c: List<double>.from(json["c"].map((x) => x.toDouble())),
        t: List<int>.from(json["t"].map((x) => x)),
      );
}
