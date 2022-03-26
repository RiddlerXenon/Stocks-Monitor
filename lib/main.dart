import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/geting_data/get_stoks_list.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({Key? key, required this.child}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Stocks Monitor';

    return RestartWidget(
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: appTitle,
        home: const MyHomePage(title: appTitle),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Stocks createState() => Stocks();
}

class Stocks extends State<MyHomePage> {
  final _channel = WebSocketChannel.connect(
      Uri.parse('wss://ws.finnhub.io?token=c8pok02ad3icps1jt07g'));

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.update),
          onPressed: () => RestartWidget.restartApp(context),
        ),
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: GetStoksList.stocksListGet(_channel),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Error!\nTry to restart app!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
