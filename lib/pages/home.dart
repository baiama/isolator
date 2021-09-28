import 'package:flutter/material.dart';
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
    _worker = MyWorker();
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
