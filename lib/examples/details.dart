import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final DateTime date;

  DetailPage({required this.date});

  @override
  Widget build(BuildContext context) {
    // Format date for display
    String formattedDate = '${date.day}-${date.month}-${date.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Date: $formattedDate'),
            // Add more details or form fields as needed
          ],
        ),
      ),
    );
  }
}
