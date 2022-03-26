import 'package:flutter/material.dart';
import 'package:flutter_application_1/geting_data/get_stocks_pr.dart';

class StreamStocks {
  static streamStocks(_broadcast, _channel, snapshotData, index) {
    return StreamBuilder(
      stream: _broadcast,
      builder: (context, snapshot1) {
        if (index != 0) {
          _channel.sink.add(
              '{"type":"unsubscribe","symbol":"${snapshotData[index - 1].symbol}"}');
        }
        _channel.sink.add(
            '{"type":"subscribe","symbol":"${snapshotData[index].symbol}"}');

        if (snapshot1.connectionState == ConnectionState.waiting) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'The actualy price\n',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ]);
        }
        if (snapshot1.data.toString() ==
            '{"msg":"Subscribing to too many symbols","type":"error"}') {
          _channel.sink.add(
              '{"type":"unsubscribe","symbol":"${snapshotData[index].symbol}"}');
        }
        if (snapshot1.data.toString() == '{"type":"ping"}') {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'The actualy price\n',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
              ]);
        }
        if (snapshot1.connectionState == ConnectionState.active &&
            snapshot1.data.toString() != '{"type":"ping"}' &&
            snapshot1.hasData &&
            !snapshot1.hasError &&
            snapshot1.data.toString() !=
                '{"msg":"Malformed message","type":"error"}' &&
            snapshot1.data.toString() !=
                '{"msg":"Subscribing to too many symbols","type":"error"}') {
          return Center(
            child: Text(
              "The actualy price\n${ParseStocksprice.parseStocksPrice('${snapshot1.data}')} \$",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          _channel.sink.add(
              '{"type":"unsubscribe","symbol":"${snapshotData[index].symbol}"}');
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'The actualy price\n',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              ]);
        }
      },
    );
  }
}
