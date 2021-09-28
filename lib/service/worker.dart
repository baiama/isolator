import 'dart:async';
import 'dart:isolate';

import 'package:isolator/service/data_helper.dart';

class MyWorker {
  late Isolate _isolate;
  late SendPort _sendPort;
  final _isolateReady = Completer<void>();
  late DataHelper _dataHelper;
  MyWorker() {
    _init();
  }

  void _init() async {
    ReceivePort _receivePort;
    _receivePort = ReceivePort();
    _receivePort.listen(_handleMessage);
    _dataHelper = DataHelper();
    _isolate = await Isolate.spawn(_isolateEntry, _receivePort.sendPort);
  }

  Future<void> get isolateReady => _isolateReady.future;

  void start() async {
    List<String> data = await _dataHelper.data;
    _sendPort.send(data);
  }

  void dispose() {
    _isolate.kill();
  }

  static void _isolateEntry(message) async {
    late SendPort sendPort;
    ReceivePort receivePort = ReceivePort();
    receivePort.listen((message) async {
      if (message is List<String>) {
        List<String> tasks = message;
        print(tasks);
        for (String task in tasks) {
          await Future.delayed(const Duration(seconds: 10));
          sendPort.send(task);
        }
        sendPort.send('last');
      }
    });

    if (message is SendPort) {
      sendPort = message;
      sendPort.send(receivePort.sendPort);
      return;
    }
  }

  void _handleMessage(message) {
    print("handle message $message");
    if (message is SendPort) {
      _sendPort = message;
      _isolateReady.complete();
    }
    if (message is String && message == 'last') {
      dispose();
    } else if (message is String) {
      _dataHelper.setData(message);
    }
  }
}
