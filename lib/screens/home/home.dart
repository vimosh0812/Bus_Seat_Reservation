import 'package:flutter/material.dart';
import 'package:project1/services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi Vimosh!'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            label: Text('Logout', style: TextStyle(color: Colors.white)),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Muikkanum!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Replace with the actual item count
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.star),
                      title: Text('Item $index'),
                      subtitle: Text('Subtitle for item $index'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Add your onPressed code here!
                print('Add new item button pressed');
              },
              icon: Icon(Icons.add),
              label: Text('Add New Item'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pinkAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
