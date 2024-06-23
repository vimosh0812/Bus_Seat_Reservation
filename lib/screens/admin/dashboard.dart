import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/screens/authentication/ticket_management.dart';
import 'package:project1/screens/admin/profile_page.dart'; // Import the ProfilePage
import 'package:intl/intl.dart'; // Import the intl package

class AdminPage extends StatefulWidget {
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  int _selectedIndex = 0; // Add selected index for navigation
  bool isColomboToBatticaloa = true; // Add a boolean to track route direction

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _swapRoute() {
    setState(() {
      isColomboToBatticaloa = !isColomboToBatticaloa;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isColomboToBatticaloa ? 'Colombo' : 'Batticaloa',
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: Icon(Icons.swap_horiz, color: Colors.white),
              onPressed: _swapRoute,
            ),
            Text(
              isColomboToBatticaloa ? 'Batticaloa' : 'Colombo',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.black, // Add background color black
      ),
      body: _selectedIndex == 0
          ? buildHomePage(now)
          : ProfilePage(), // Display Home or Profile
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

  Widget buildHomePage(DateTime now) {
    return ListView(
      children: [
        for (int i = 0; i < 14; i++)
          buildRow(context, now.add(Duration(days: i))),
      ],
    );
  }

  Widget buildRow(BuildContext context, DateTime date) {
    String dayStr = date.day < 10 ? '0${date.day}' : '${date.day}';
    String documentName = '$dayStr-${date.month}-${date.year}';
    String getMonthName(int monthNumber) {
      return DateFormat.MMMM().format(DateTime(0, monthNumber));
    }

    String month = getMonthName(date.month);

    // Determine the route based on the boolean value
    String route = isColomboToBatticaloa
        ? 'Colombo to Batticaloa'
        : 'Batticaloa to Colombo';

    // Reference to the buses collection and specific document for the date
    CollectionReference busesCollection = firestore.collection('buses');
    DocumentReference busDocRoute = busesCollection.doc(route);
    DocumentReference busDocRef =
        busDocRoute.collection(month).doc(documentName);

    return FutureBuilder<DocumentSnapshot>(
      future: busDocRef.get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Return an empty container while loading
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return Container(); // Return an empty container if document does not exist
        }

        // Document exists, proceed with building the cell
        bool isBookingOpen = false;
        bool isThere = false; // Add an initializer expression for 'isThere'
        if (snapshot.data!.data() is Map<String, dynamic>) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data.containsKey('isBookingOpen')) {
            isBookingOpen = data['isBookingOpen'] ?? false;
          }
          isThere = true; // Set 'isThere' to true if the document exists
        }
        Color statusColor = isBookingOpen ? Colors.green : Colors.red;
        String statusText = isBookingOpen ? 'Active' : 'Disabled';

        return buildCell(
          route,
          month,
          documentName,
          date,
          statusText,
          statusColor,
          isBookingOpen,
          isThere,
          context,
        );
      },
    );
  }

  Widget buildCell(
    String route,
    String month,
    String formattedDate,
    DateTime date,
    String statusText,
    Color statusColor,
    bool isBookingOpen,
    bool isThere,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: ListTile(
          leading: Text(formattedDate),
          trailing: ElevatedButton(
            onPressed: () {
              if (!isThere) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Document does not exist'),
                  ),
                );
                return;
              } else {
                if (!isBookingOpen) {
                  // Show popup indicating booking is disabled
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Booking Disabled'),
                        content: Text(
                            'Booking is currently disabled for this date. Do you want to enable it?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Enable Booking'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Toggle booking status
                              toggleBookingStatus(
                                  route, month, formattedDate, isBookingOpen);
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Navigate to Ticket Management Page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketManagementPage(
                          scheduleDate: formattedDate,
                          route: route,
                          month: month),
                    ),
                  );
                }
              }
            },
            child: Text('View More'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          onTap: () {
            if (!isThere) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Document does not exist'),
                ),
              );
              return;
            }
            toggleBookingStatus(route, month, formattedDate, isBookingOpen);
          },
          title: ElevatedButton(
            onPressed: () {
              if (!isThere) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Document does not exist'),
                  ),
                );
                return;
              }
              toggleBookingStatus(route, month, formattedDate, isBookingOpen);
            },
            child: Text(statusText),
            style: ElevatedButton.styleFrom(
              backgroundColor: statusColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggleBookingStatus(String route, String month, String documentName,
      bool currentStatus) async {
    CollectionReference busesCollection = firestore.collection('buses');
    DocumentReference busDocRoute = busesCollection.doc(route);
    DocumentReference busDocRef =
        busDocRoute.collection(month).doc(documentName);

    try {
      await busDocRef.update({'isBookingOpen': !currentStatus});
      setState(() {});
    } catch (e) {
      print('Error updating booking status: $e');
    }
  }
}
