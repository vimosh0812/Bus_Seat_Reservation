import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/screens/wrapper.dart';

class adminConfirmation extends StatefulWidget {
  final List<int> selectedSeats;
  final String route;
  final String month;
  final String scheduleDate;

  const adminConfirmation({
    Key? key,
    required this.selectedSeats,
    required this.route,
    required this.month,
    required this.scheduleDate,
  }) : super(key: key);

  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<adminConfirmation> {
  void reloadSeatData() {
    setState(() {
      widget.selectedSeats.clear();
    });
  }

  late List<int> selectedSeatsX;

  @override
  void initState() {
    super.initState();
    selectedSeatsX = List<int>.from(widget.selectedSeats);
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _gender = "gents"; // Default selection

  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  bool isValidMobile(String mobile) {
    final RegExp mobileRegExp = RegExp(
      r'^\+?[0-9]{10,15}$',
    );
    return mobileRegExp.hasMatch(mobile);
  }

  bool isValidName(String value) {
    final RegExp nameRegExp = RegExp(
      r'^[a-zA-Z ]+$',
    );
    return nameRegExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        automaticallyImplyLeading:
            false, // This removes the default back button
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context); // Custom back button functionality
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(34.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.selectedSeats.length == 1) ...{
                      Text(
                        'Selected seat Number: ${widget.selectedSeats[0]}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    } else if (widget.selectedSeats.length > 1) ...{
                      Text(
                        'Selected seat Numbers: ${widget.selectedSeats.join(', ')}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    },
                  ],
                ),
                SizedBox(height: 18),
                Container(
                  width: screenWidth > 550 ? 400 : double.infinity,
                  decoration: BoxDecoration(
                    color: (_gender == "ladies")
                        ? Color.fromARGB(60, 233, 30, 98)
                        : Color.fromARGB(150, 224, 224, 224),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(42.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Booking Confirmation',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.only(left: 18.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      hintText: 'Name',
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a name';
                                      } else if (!isValidName(value)) {
                                        return 'Please enter a valid name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 16),
                          // Container(
                          //   padding: const EdgeInsets.only(left: 18.0),
                          //   decoration: BoxDecoration(
                          //     border:
                          //         Border.all(color: Colors.black, width: 1.0),
                          //     borderRadius: BorderRadius.circular(8.0),
                          //   ),
                          //   child: Row(
                          //     children: [
                          //       Icon(Icons.email),
                          //       SizedBox(width: 8),
                          //       Expanded(
                          //         child: TextFormField(
                          //           controller: _emailController,
                          //           decoration: InputDecoration(
                          //             hintText: ' E-mail address',
                          //             border: InputBorder.none,
                          //           ),
                          //           keyboardType: TextInputType.emailAddress,
                          //           validator: (value) {
                          //             if (value == null || value.isEmpty) {
                          //               return 'Please enter an email address';
                          //             } else if (!isValidEmail(value)) {
                          //               return 'Please enter a valid email address';
                          //             }
                          //             return null;
                          //           },
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.only(left: 18.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.phone),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextFormField(
                                    controller: _mobileController,
                                    decoration: InputDecoration(
                                      hintText: 'Mobile number',
                                      border: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a mobile number';
                                      } else if (!isValidMobile(value)) {
                                        return 'Please enter a valid mobile number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("ladies"),
                              Checkbox(
                                value: _gender == "ladies",
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      _gender = "ladies";
                                    }
                                  });
                                },
                              ),
                              Text("gents"),
                              Checkbox(
                                value: _gender == "gents",
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      _gender = "gents";
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _gender == "ladies"
                                  ? Colors.pink
                                  : const Color.fromARGB(255, 14, 8, 46),
                              foregroundColor: Colors.white,
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _updateSeatStatus(
                                  widget.selectedSeats,
                                  context,
                                  _emailController,
                                  _mobileController,
                                  _nameController,
                                  widget.route,
                                  widget.month,
                                  widget.scheduleDate,
                                  _gender,
                                );
                                reloadSeatData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Wrapper()));
                              }
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _updateSeatStatus(
  List<int> seatNumbers,
  BuildContext context,
  TextEditingController email,
  TextEditingController mobile,
  TextEditingController name,
  String route,
  String month,
  String scheduleDate,
  String gender, // Add gender parameter
) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentReference seatDocRef = firestore
      .collection('buses')
      .doc(route)
      .collection(month)
      .doc(scheduleDate);

  List<int> seatsToUpdate = List.from(seatNumbers);
  for (int seatNumber in seatsToUpdate) {
    String seatId =
        (seatNumber < 10) ? 'seat0${seatNumber}' : 'seat${seatNumber}';
    DocumentReference seatDocRefInner =
        seatDocRef.collection("seats").doc(seatId);

    try {
      await seatDocRefInner.update({
        'isCounter': true, // Set isCounter to false
        'isBooked': false,
        'emailID': email.text.toString(),
        'mobileNumber': mobile.text.toString(),
        'name': name.text.toString(),
        'type': gender,
      });
    } catch (e) {
      print('Failed to update seat $seatNumber: $e');
    }
  }
}
