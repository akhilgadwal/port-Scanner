import 'package:flutter/material.dart';
import 'package:port_scanner/components/bar.dart';

import '../class/postStatus.dart';
import '../components/switch.dart';
import '../services/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textfile = TextEditingController();
  String host = '';
  String apiKey = 'c9430a93ae16dac8304f200c456587f504083e8c';
  List<PortStatus> output = [];
  bool isLoading = false;

  //creating a reset button
  void resetScreen() {
    setState(() {
      host = '';
      output = [];
    });
  }

  void scanPorts() async {
    if (host.isEmpty) {
      setState(() {
        output = [
          PortStatus(
            message: 'Please enter a host to scan.',
            portNumber: '',
            status: '',
          )
        ];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final ports = await PortScanAPI.scanPorts(host, apiKey);

      setState(() {
        output = ports;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        output = [
          PortStatus(
            message: 'Error: $e',
            portNumber: '',
            status: '',
          )
        ];
        isLoading = false;
      });
    }
    _textfile.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Center(
          child: Text('Port Scanner'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textfile,
              cursorColor: Colors.grey.shade600,
              decoration: InputDecoration(
                  labelText: 'Host',
                  labelStyle: const TextStyle(color: Colors.deepPurpleAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.deepPurpleAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.deepPurpleAccent))),
              onChanged: (value) {
                setState(
                  () {
                    host = value;
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: resetScreen,
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            const SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurpleAccent)),
                onPressed: isLoading ? null : scanPorts,
                child: const Text('Scan Ports'),
              ),
            ),
            const SizedBox(height: 16.0),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (host.isEmpty && output.isEmpty)
              const Center(
                child: Text(
                  'Please enter a host to scan.',
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: output.length,
                  itemBuilder: (BuildContext context, int index) {
                    final portStatus = output[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Container(
                          width: 200,
                          height: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Port ${portStatus.portNumber}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: portStatus.status == 'open'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              Text(
                                ' ${portStatus.status}',
                                style: TextStyle(
                                  color: portStatus.status == 'open'
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              StatusSwitchIcon(status: portStatus.status)
                            ],
                          )),
                      // child: Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [

                      //     // MyBar(
                      //     //     port: 'Port ${portStatus.portNumber}',
                      //     //     status: ' ${portStatus.status}'),
                      //     // Text(
                      //     //   'Port ${portStatus.portNumber}',
                      //     //   style: TextStyle(
                      //     //     fontSize: 16,
                      //     //     color: portStatus.status == 'open'
                      //     //         ? Colors.green
                      //     //         : Colors.red,
                      //     //   ),
                      //     // ),
                      // Text(
                      //   ' ${portStatus.status}',
                      //   style: TextStyle(
                      //       color: portStatus.status == 'open'
                      //           ? Colors.green
                      //           : Colors.red,
                      //       fontWeight: FontWeight.bold,),
                      // )
                      //   ],
                      // ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
