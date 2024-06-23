import 'package:flutter/material.dart';
import 'package:project1/examples/qrscanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class Qrgen extends StatefulWidget {
  const Qrgen({Key? key}) : super(key: key);

  @override
  _QrgenState createState() => _QrgenState();
}

class _QrgenState extends State<Qrgen> {
  final TextEditingController _inputController = TextEditingController();
  String? _qrData;

  Future<String> _generateJwt(String data) async {
    // Example payload
    final payload = {'data': data};

    // Generate JWT
    final jwt = JWT(payload);
    final token =
        jwt.sign(SecretKey('RoyalExpress')); // Use your secret key here
    return token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'QR Code Generator',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextField(
              //   controller: _inputController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     hintText: 'Enter data to encode',
              //   ),
              // ),
              // const SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () async {
              //     final jwtToken = await _generateJwt("22/06/2024-24");
              //     setState(() {
              //       _qrData = jwtToken;
              //     });
              //   },
              //   child: const Text('Generate QR Code'),
              // ),
              const SizedBox(height: 16),
              if (_qrData != null && _qrData!.isNotEmpty)
                Container(
                  child: QrImageView(
                    data: _qrData!,
                    version: QrVersions.auto,
                    size: 180.0,
                  ),
                ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const QrScan(),
              //       ),
              //     );
              //   },
              //   child: const Text('Scan QR Code'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
