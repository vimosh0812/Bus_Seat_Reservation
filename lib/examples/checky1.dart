import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeatReservationApp extends StatelessWidget {
  SeatReservationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Seat Reservation',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            signOut();
          },
          color: Colors.grey,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _initiateFirebase(context);
              },
              child: Text('Initiate Firebase'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initiateFirebase(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference busesCollection = firestore.collection('buses');
    DocumentReference busDocRef = busesCollection.doc('21june');

    // Create the '21june' document with an empty Map
    await busDocRef.set(Map<String, dynamic>());

    // Create seat documents for seats 1 to 10
    for (int seatNumber = 1; seatNumber <= 45; seatNumber++) {
      String seatId = 'seat$seatNumber';
      DocumentReference seatDocRef = busDocRef.collection("seats").doc(seatId);
      if (seatNumber <= 10) {
        await seatDocRef.set({
          'type': '', // Add default values for fields
          'isBooked': false,
          'isCounter': true,
          'emailID': '',
          'mobileNumber': '',
          'bookingID': '',
          'name': '',
          'value': seatNumber,
        });
      } else if (seatNumber == 21 || seatNumber == 22) {
        await seatDocRef.set({
          'type': 'ladies', // Add default values for fields
          'isBooked': false,
          'isCounter': false,
          'emailID': '',
          'mobileNumber': '',
          'bookingID': '',
          'name': '',
          'value': seatNumber,
        });
      } else {
        await seatDocRef.set({
          'type': 'gents', // Add default values for fields
          'isBooked': false,
          'isCounter': false,
          'emailID': '',
          'mobileNumber': '',
          'bookingID': '',
          'name': '',
          'value': seatNumber,
        });
      }

      // Navigate to a new page
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewPage()),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Error in signOut: $e');
      return null;
    }
  }
}

class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Text('This is a new page!'),
      ),
    );
  }
}
