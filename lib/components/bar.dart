import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyBar extends StatelessWidget {
  const MyBar({super.key, required this.port, required this.status});
  final String port;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      width: 200,
      height: 0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.grey.shade200),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Text(port), Text(status)]),
    );
  }
}
