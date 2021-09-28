import 'package:flutter/material.dart';
import 'package:isolator/service/data_helper.dart';
import 'package:isolator/service/worker.dart';
import 'details.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late MyWorker _worker;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final dataHelper = DataHelper();
    await dataHelper.setUpData();
    _worker = MyWorker();
    await _worker.isolateReady;
    _worker.start();
  }

  @override
  void dispose() {
    super.dispose();
    _worker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyDetailsPage()));
          },
          child: const Text('Hello'),
        ),
      ),
    );
  }
}
