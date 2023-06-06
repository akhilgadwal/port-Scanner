import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:port_scanner/screen/screen.dart';

void main() {
  runApp(const PortScanApp());
}

class PortScanApp extends StatelessWidget {
  const PortScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
