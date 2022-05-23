import 'package:flutter/material.dart';

class ExampleThird extends StatefulWidget {
  const ExampleThird({Key? key}) : super(key: key);

  @override
  State<ExampleThird> createState() => _ExampleThirdState();
}

class _ExampleThirdState extends State<ExampleThird> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExampleThird'),
      ),
    );
  }
}
