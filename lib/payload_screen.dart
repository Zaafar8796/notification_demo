import 'package:flutter/material.dart';

class PayloadScreen extends StatelessWidget {
  final String? payload;
  const PayloadScreen({Key? key, @required this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload ?? ''),
      ),
      body: Center(
        child: Text(payload ?? ''),
      ),
    );
  }
}
