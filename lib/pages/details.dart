import 'package:flutter/material.dart';

class MyDetailsPage extends StatelessWidget {
  const MyDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Details page'),
        ),
      ),
    );
  }
}
