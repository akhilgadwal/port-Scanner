import 'dart:convert';
import 'package:http/http.dart' as http;

import '../class/postStatus.dart';

class PortScanAPI {
  static Future<List<PortStatus>> scanPorts(String host, String apiKey) async {
    String apiUrl =
        'https://api.viewdns.info/portscan/?host=$host&apikey=$apiKey&output=json';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final jsonData = jsonDecode(response.body);

      final ports = jsonData['response']['port'];
      if (ports is List) {
        return ports.map<PortStatus>((port) {
          final portNumber = port['number'].toString();
          final status = port['status'].toString();
          return PortStatus(
            portNumber: portNumber,
            status: status,
            message: '', // Update the message parameter here
          );
        }).toList();
      } else if (ports is String) {
        final portNumber = jsonData['response']['port']['number'].toString();
        final status = jsonData['response']['port']['status'].toString();
        return [
          PortStatus(
            portNumber: portNumber,
            status: status,
            message: '', // Update the message parameter here
          )
        ];
      }

      return [];
    } catch (e) {
      throw e;
    }
  }
}
