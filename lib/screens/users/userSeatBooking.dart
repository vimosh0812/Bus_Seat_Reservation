import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project1/screens/users/confirmation.dart';

class userSeatBooking extends StatefulWidget {
  final String selectedDate;
  final String selectedRoute;
  final String selectedMonth;
  const userSeatBooking({
    Key? key,
    required this.selectedDate,
    required this.selectedMonth,
    required this.selectedRoute,
  }) : super(key: key);

  @override
  _userSeatBookingState createState() => _userSeatBookingState();
}

class _userSeatBookingState extends State<userSeatBooking> {
  List<int> selectedSeats = [];

  Stream<List<Map<String, dynamic>>> seatDataStream() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference busDocRef = firestore
        .collection('buses')
        .doc(widget.selectedRoute)
        .collection(widget.selectedMonth)
        .doc(widget.selectedDate);
    return busDocRef.collection('seats').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'seatId': doc.id,
          'isBooked': doc['isBooked'],
          'isCounter': doc['isCounter'],
          'type': doc['type'],
        };
      }).toList();
    });
  }

  Stream<bool> seatDataStream1() {
    FirebaseFirestore firestore1 = FirebaseFirestore.instance;
    DocumentReference busDocRef1 = firestore1
        .collection('buses')
        .doc(widget.selectedRoute)
        .collection(widget.selectedMonth)
        .doc(widget.selectedDate);

    return busDocRef1.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return snapshot.get('isBookingOpen');
      } else {
        return false;
      }
    });
  }

  void reloadSeatData() {
    setState(() {
      selectedSeats.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select your seats"),
          titleTextStyle: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.grey,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
          centerTitle: true,
        ),
        body: StreamBuilder<bool>(
          stream: seatDataStream1(),
          builder: (context, bookingStatusSnapshot) {
            if (bookingStatusSnapshot.connectionState ==
                ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              );
            } else if (bookingStatusSnapshot.hasError) {
              return Center(child: Text('Error fetching booking status'));
            } else if (!bookingStatusSnapshot.hasData ||
                !bookingStatusSnapshot.data!) {
              return Center(child: Text('Bookings have not started yet'));
            } else {
              return StreamBuilder<List<Map<String, dynamic>>>(
                stream: seatDataStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching seat data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Booking has not started yet'));
                  } else {
                    List<Map<String, dynamic>> seatData = snapshot.data!;
                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 42.0,
                                  top: 10.0,
                                  left: 42.0,
                                  right: 42.0,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.selectedRoute,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.selectedDate,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 240,
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Image(
                                              height: 50,
                                              width: 50,
                                              image: AssetImage(
                                                  'images/wheel.png'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [1, 2, 3, 4]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [5, 6, 7, 8]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [9, 10, 11, 12]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [13, 14, 15, 16]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [17, 18, 19, 20]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [21, 22, 23, 24]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [25, 26, 27, 28]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [29, 30, 31, 32]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [33, 34, 35, 36]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(seatData, [37, 38, 39, 40]),
                                    SizedBox(height: 16),
                                    _buildSeatRow(
                                        seatData, [41, 42, 43, 44, 45]),
                                    SizedBox(height: 32),
                                    _buildLegendRow(),
                                    SizedBox(height: 32),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Color.fromARGB(255, 14, 8, 46),
                                        foregroundColor: Colors.white,
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 24,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        // _updateSeatStatus(selectedSeats, context);
                                        _collectDetails(
                                            selectedSeats,
                                            widget.selectedRoute,
                                            widget.selectedMonth,
                                            widget.selectedDate,
                                            context);
                                        print(selectedSeats);
                                        // reload
                                        // reloadSeatData();
                                      },
                                      child: Text('Proceed'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              );
            }
          },
        ));
  }

  Row _buildSeatRow(
      List<Map<String, dynamic>> seatData, List<int> seatNumbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: seatNumbers.asMap().entries.map((entry) {
        var index = entry.key;
        var seatNumber = entry.value;
        var SeatNo = entry.value < 10 ? "0${entry.value}" : entry.value;

        var seat = seatData.firstWhere(
          (seat) => seat['seatId'] == 'seat$SeatNo',
          orElse: () => {'isBooked': false, 'isCounter': false},
        );

        bool isBooked = seat['isBooked'] ?? false;
        bool isCounter = seat['isCounter'] ?? false;
        var seatComponent = _SeatComponent(
          value: seatNumber,
          isBooked: isBooked,
          isCounter: isCounter,
          type: seat['type'],
          marginRight: 8.0,
          onSeatBooked: reloadSeatData,
          selectedSeats: selectedSeats,
        );
        if (seatNumbers.length == 4 && index == 1) {
          return Row(
            children: [
              seatComponent,
              SizedBox(width: 56),
            ],
          );
        } else {
          return seatComponent;
        }
      }).toList(),
    );
  }

  Widget _buildLegendRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: _buildLegendItem(
                  Colors.orange, Colors.orange, 'Counter Seats'),
            ),
            Expanded(
              flex: 1,
              child: _buildLegendItem(
                  Colors.blue, Colors.blue, 'Processing seats'),
            )
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child:
                  _buildLegendItem(Colors.pink, Colors.pink, 'Ladies\' Seats'),
            ),
            Expanded(
              flex: 1,
              child: _buildLegendItem(Color.fromARGB(255, 41, 227, 47),
                  Color.fromARGB(255, 41, 227, 47), 'Booked Seats'),
            )
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildLegendItem(Colors.white, Colors.black, 'Available Seats'),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, Color bcolor, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: bcolor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 8),
        Text(label),
      ],
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

void _collectDetails(List<int> selectedSeats, String route, String month,
    String selectedDate, BuildContext context) {
  if (selectedSeats.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please select at least one seat'),
      ),
    );
    return;
  } else {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Confirmation(
            selectedSeats: selectedSeats,
            route: route,
            month: month,
            scheduleDate: selectedDate),
      ),
    );
  }
}

class _SeatComponent extends StatefulWidget {
  final int? value;
  final bool isBooked;
  final bool isCounter;
  final String? type;
  final double? marginRight;
  final VoidCallback onSeatBooked;
  final List<int> selectedSeats;

  const _SeatComponent({
    Key? key,
    required this.value,
    required this.type,
    required this.isBooked,
    required this.isCounter,
    this.marginRight = 0.0,
    required this.onSeatBooked,
    required this.selectedSeats,
  }) : super(key: key);

  @override
  _SeatComponentState createState() => _SeatComponentState();
}

class _SeatComponentState extends State<_SeatComponent> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.selectedSeats.contains(widget.value);
  }

  @override
  void didUpdateWidget(covariant _SeatComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    isSelected = widget.selectedSeats.contains(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (!widget.isBooked && !widget.isCounter) {
          setState(() {
            isSelected = !isSelected;
          });

          if (isSelected) {
            widget.selectedSeats.add(widget.value!);
          } else {
            widget.selectedSeats.remove(widget.value);
          }
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: _getColor(),
          border: Border.all(
            color: (widget.type == 'ladies') ? Colors.pink : Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        margin: EdgeInsets.only(
          right: widget.marginRight ?? 0,
        ),
        child: Center(
          child: Text(
            widget.value! < 10 ? "0${widget.value}" : widget.value.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (widget.type == 'ladies') {
      if (widget.isCounter) {
        return Color.fromARGB(120, 233, 30, 98);
      } else {
        if (isSelected) {
          return Colors.pink;
        } else {
          return Colors.white;
        }
      }
    } else if (widget.isCounter) {
      return Color.fromARGB(112, 255, 153, 0);
    } else if (widget.isBooked) {
      return Color.fromARGB(172, 165, 165, 165);
    } else {
      if (isSelected) {
        return Color.fromARGB(255, 5, 194, 236);
      } else {
        return Colors.white;
      }
    }
  }
}
