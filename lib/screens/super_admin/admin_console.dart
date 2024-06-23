import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/screens/super_admin/superAdminProfile.dart';

class AdminConsole extends StatefulWidget {
  @override
  _AdminConsoleState createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0; // Add selected index for navigation

  // List of months with their names
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  // Function to initialize tickets for the entire month
  Future<void> _initiateCBMonthTickets(
      BuildContext context, String month) async {
    int currentYear = DateTime.now().year;
    int daysInMonth = DateTime(currentYear, months.indexOf(month) + 2, 0).day;

    // Iterate over each day of the month and initialize tickets
    for (int day = 1; day <= daysInMonth; day++) {
      // Construct document name for the date
      String dayStr =
          day < 10 ? '0$day' : '$day'; // Add leading zero if day < 10
      String documentName = '$dayStr-${months.indexOf(month) + 1}-$currentYear';

      // Reference to the buses collection and specific document for the date
      CollectionReference busesCollection = firestore.collection('buses');
      DocumentReference busDocRoute =
          busesCollection.doc("Colombo to Batticaloa");
      DocumentReference busDocRef =
          busDocRoute.collection(month).doc(documentName);

      // Create the document with an empty Map and set isBookingOpen to false
      await busDocRef.set({
        'isBookingOpen': true, // Initialize isBookingOpen field
      });

      // Create seat documents for seats 1 to 45
      for (int seatNumber = 1; seatNumber <= 45; seatNumber++) {
        String seatNoStr = seatNumber < 10
            ? '0$seatNumber'
            : '$seatNumber'; // Add leading zero if day < 10
        String seatId = 'seat$seatNoStr';
        DocumentReference seatDocRef =
            busDocRef.collection("seats").doc(seatId);
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
      }
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tickets initialized for $month')));
  }

  Future<void> _initiateBCMonthTickets(
      BuildContext context, String month) async {
    int currentYear = DateTime.now().year;
    int daysInMonth = DateTime(currentYear, months.indexOf(month) + 1, 0).day;

    // Iterate over each day of the month and initialize tickets
    for (int day = 1; day <= daysInMonth; day++) {
      // Construct document name for the date
      String dayStr =
          day < 10 ? '0$day' : '$day'; // Add leading zero if day < 10
      String documentName = '$dayStr-${months.indexOf(month) + 1}-$currentYear';

      // Reference to the buses collection and specific document for the date
      CollectionReference busesCollection = firestore.collection('buses');
      DocumentReference busDocRoute =
          busesCollection.doc("Batticaloa to Colombo");
      DocumentReference busDocRef =
          busDocRoute.collection(month).doc(documentName);

      // Create the document with an empty Map and set isBookingOpen to false
      await busDocRef.set({
        'isBookingOpen': true, // Initialize isBookingOpen field
      });

      // Create seat documents for seats 1 to 45
      for (int seatNumber = 1; seatNumber <= 45; seatNumber++) {
        String seatNoStr = seatNumber < 10
            ? '0$seatNumber'
            : '$seatNumber'; // Add leading zero if day < 10
        String seatId = 'seat$seatNoStr';
        DocumentReference seatDocRef =
            busDocRef.collection("seats").doc(seatId);
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
      }
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tickets initialized for $month')));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Super Admin Page',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _selectedIndex == 0 ? buildHomePage() : SuperAdminProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget buildHomePage() {
    return ListView.builder(
      itemCount: months.length,
      itemBuilder: (context, index) {
        String month = months[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text(month),
            trailing: ElevatedButton(
              onPressed: () {
                _initiateCBMonthTickets(context, month);
                // _initiateBCMonthTickets(context, month);
              },
              child: Text('Initiate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
