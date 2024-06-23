import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project1/screens/admin/adminSeatBooking.dart';
import 'package:project1/screens/admin/dashboard.dart';

class TicketManagementPage extends StatefulWidget {
  final String scheduleDate;
  final String route;
  final String month;
  TicketManagementPage(
      {required this.scheduleDate, required this.route, required this.month});

  _TicketManagementPageState createState() => _TicketManagementPageState();
}

class _TicketManagementPageState extends State<TicketManagementPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              'Ticket Management',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminSeatBooking(
                      scheduleDate: widget.scheduleDate,
                      route: widget.route,
                      month: widget.month),
                ),
              );
            },
          ),
        ],
        backgroundColor: Color(0xFF00113E),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('buses')
                    .doc(widget.route)
                    .collection(widget.month)
                    .doc(widget.scheduleDate)
                    .collection('seats')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }

                  List<DataRow> rows = [];
                  snapshot.data!.docs.forEach((document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    // if (data['isCounter'] == false) {
                    if (data['type'].toString() == 'ladies') {
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
                        color: MaterialStateProperty.all(Colors.pink),
                      ));
                    } else {
                      rows.add(DataRow(
                        cells: [
                          DataCell(Text(data['value'].toString(),
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(data['type'],
                              style: TextStyle(color: Colors.black))),
                          DataCell(Text(data['mobileNumber'].toString(),
                              style: TextStyle(color: Colors.black))),
                        ],
                        color: MaterialStateProperty.all(Colors.white),
                      ));
                    }
                  });
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text('Seat No',
                                style: TextStyle(color: Colors.black))),
                        DataColumn(
                            label: Text('Type',
                                style: TextStyle(color: Colors.black))),
                        DataColumn(
                            label: Text('Mobile Number',
                                style: TextStyle(color: Colors.black))),
                      ],
                      rows: rows,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
