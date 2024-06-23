import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeatReservationAppx extends StatefulWidget {
  const SeatReservationAppx({Key? key}) : super(key: key);

  @override
  _SeatReservationAppxState createState() => _SeatReservationAppxState();
}

class _SeatReservationAppxState extends State<SeatReservationAppx> {
  String? selectedRoute;
  bool? isSearched = false; // Define the selectedRoute variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00113E),
        title: Center(
          child: Text(
            'Online Booking',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFFF8811)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Travel Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        // this is to choose route
                        child: DropdownButton<String>(
                          value: selectedRoute,
                          hint: Text('Select Route'),
                          items: <String>[
                            'Batticaloa to Colombo',
                            'Colombo to Batticaloa'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedRoute = newValue;
                              isSearched = true;
                              print(selectedRoute); // Print the selectedRoute
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (selectedRoute != null) ...{
                  SeatDataTable(),
                },
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          onTap: (int index) {
            if (index == 0) {
            } else if (index == 1) {
            } else if (index == 2) {}
          },
          selectedItemColor: Colors.blue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_num_outlined),
              label: 'Booking',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
              label: 'Scanner',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class SeatDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('buses')
          .doc('21june')
          .collection('seats')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<DataRow> rows = [];
        snapshot.data!.docs.forEach((document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          if (data['isBooked'] == true) {
            if (data['type'].toString() == 'ladies') {
              // add colors to ladies seat
              rows.add(DataRow(
                cells: [
                  DataCell(Text(
                    data['value'].toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    data['type'],
                    style: TextStyle(color: Colors.white),
                  )),
                  DataCell(Text(
                    data['mobileNumber'].toString(),
                    style: TextStyle(color: Colors.white),
                  )),
                ],
                color: MaterialStateProperty.all(Color(0xFF00113E)),
              ));
            } else {
              rows.add(DataRow(
                cells: [
                  DataCell(Text(data['value'].toString())),
                  DataCell(Text(data['type'])),
                  DataCell(Text(data['mobileNumber'].toString())),
                ],
              ));
            }
          }
        });
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Seat No')),
              DataColumn(label: Text('Type')),
              DataColumn(label: Text('Mobile Number')),
            ],
            rows: rows,
          ),
        );
      },
    );
  }
}
