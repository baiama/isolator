import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';

class MyWorker {
  late Isolate _isolate;
  late ReceivePort _receivePort;
  MyWorker() {
    _init();
  }

  void _init() async {
    _receivePort = ReceivePort();
    _receivePort.listen(_handleMessage);
    _isolate = await Isolate.spawn(_isolateEntry, _receivePort.sendPort);
  }

  void dispose() {
    _receivePort.close();
    _isolate.kill();
  }

  static void _isolateEntry(dynamic message) async {
    print("_isolateEntry $message");
    print('state delay');
    await Future.delayed(const Duration(seconds: 2));
    print('end delay');
    if (message is SendPort) {
      message.send("work end");
    }
    message.send("work end");
  }

  void _handleMessage(message) {
    print("handle message $message");
  }
}
