import 'package:flutter/material.dart';

class StatusSwitchIcon extends StatelessWidget {
  final String status;

  const StatusSwitchIcon({required this.status});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    if (status == 'open') {
      icon = Icons.check;
      color = Colors.green;
    } else {
      icon = Icons.close;
      color = Colors.red;
    }

    return Icon(
      icon,
      color: color,
    );
  }
}
