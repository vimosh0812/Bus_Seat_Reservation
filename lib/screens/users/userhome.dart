import 'package:flutter/material.dart';
import 'package:project1/screens/users/userSeatBooking.dart';

class userBusBookingHomeScreen extends StatefulWidget {
  const userBusBookingHomeScreen({Key? key}) : super(key: key);

  @override
  State<userBusBookingHomeScreen> createState() => _BusBookingHomeScreenState();
}

class _BusBookingHomeScreenState extends State<userBusBookingHomeScreen> {
  int notificationCount = 5; // Example notification count
  DateTime? selectedDate;
  String? fromCity;
  String? toCity;
  bool _searchPerformed = false;
  String? route;
  String? selectedDateS;
  String? selectedMonth;
  List<String> months = [
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(
        now.year, now.month, now.day); // First day of the current month
    final DateTime lastDate = DateTime(
        now.year, now.month, now.day + 7); // Last day of the current month

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (DateTime date) =>
          true, // Always return true to allow selection
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF00113E), // Header background color
              onPrimary: Color(0xFFFF8811), // Header text color
              surface: Colors.white, // Background color
              onSurface: Colors.black, // Calendar dates color
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _resetForm() {
    setState(() {
      fromCity = null;
      toCity = null;
      selectedDate = null;
      _searchPerformed = false;
    });
  }

  Future<void> _search(BuildContext context) async {
    String errorMessage = '';
    if (fromCity == null) {
      errorMessage = 'Please select a departure city.';
    } else if (toCity == null) {
      errorMessage = 'Please select an arrival city.';
    } else if (selectedDate == null) {
      errorMessage = 'Please select a date.';
    } else if (fromCity == toCity) {
      errorMessage = 'Departure and arrival cities cannot be the same.';
    }

    if (errorMessage.isNotEmpty) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Color(0xFF00113E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Note !',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            errorMessage,
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetForm(); // Reset form data
              },
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFFFF8811),
              ),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    } else {
      _searchPerformed = true;
      route = '$fromCity to $toCity';
      selectedDate!.day < 10
          ? selectedDateS =
              '0${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}'
          : selectedDateS =
              '${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}';
      selectedMonth = months[selectedDate!.month - 1];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => userSeatBooking(
              selectedDate: selectedDateS!,
              selectedRoute: route!,
              selectedMonth: selectedMonth!),
        ),
      );
    }

    setState(() {
      _searchPerformed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF9BCFFF),
        title: Center(
          child: Text(
            'Online Booking',
            style: TextStyle(
                color: Colors.black,
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double bookingWidth = screenWidth > 550 ? 500 : screenWidth;

          double ticketWidth = screenWidth > 550 ? 500 : screenWidth;
          double smallFontSize = screenWidth > 550 ? 12 : 10;
          double largeFontSize = screenWidth > 550 ? 14 : 12;
          double heightSize = screenWidth > 0 ? 118 : 110;

          EdgeInsets buttonPadding = screenWidth > 550
              ? EdgeInsets.symmetric(horizontal: 12, vertical: 10)
              : EdgeInsets.symmetric(horizontal: 10);

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF9BCFFF), // First color of the gradient
                      Color(0xFF5D7C99), // Second color of the gradient
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 280,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // About Us section
                          SizedBox(height: 40), // Space between sections
                          Text(
                            "About Us",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              color: Color(0xFF00113E),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "We are committed to providing the best travel experience for our customers. "
                              "Our buses are equipped with all the modern amenities to ensure a comfortable journey. "
                              "We value your time and ensure timely departures and arrivals. "
                              "Book your tickets with us and enjoy a seamless travel experience.",
                              style: TextStyle(fontFamily: "Poppins"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20), // Space between sections
                          Text(
                            "Our Buses",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              color: Color(0xFF00113E),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Container(
                                  width: 300,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/bus2.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 10), // Space between images (buses)
                                Container(
                                  width: 300,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/bu4.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 10), // Space between images (buses)
                                Container(
                                  width: 300,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/bus1.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: 10), // Space between images (buses)
                                Container(
                                  width: 300,
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/bu3.jpeg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 10,
                right: 10,
                child: Column(children: []),
              ),
              Positioned(
                top: 0,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF00113E),
                                    Color(0xFF002254)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                color: Colors
                                    .transparent, // Make the card transparent
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            child: InkWell(
                                              onTap: () async {
                                                final selected =
                                                    await showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                    backgroundColor: Color(
                                                        0xFF00113E), // Dialog background color
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    title: Text(
                                                      'Select Departure City',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    children: [
                                                      SimpleDialogOption(
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              'Colombo');
                                                        },
                                                        child: Text(
                                                          'Colombo',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                      ),
                                                      SimpleDialogOption(
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              'Batticaloa');
                                                        },
                                                        child: Text(
                                                          'Batticaloa',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                if (selected != null) {
                                                  setState(() {
                                                    fromCity =
                                                        selected as String?;
                                                  });
                                                }
                                              },
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  labelText: 'From',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                  filled: true,
                                                  fillColor: Color(
                                                      0xFF00113E), // Background color of the input field
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.my_location_sharp,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: Text(
                                                  fromCity ??
                                                      'Select Departure City',
                                                  style: TextStyle(
                                                    color: fromCity == null
                                                        ? Colors.grey
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          Container(
                                            child: InkWell(
                                              onTap: () async {
                                                final selected =
                                                    await showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                    backgroundColor: Color(
                                                        0xFF00113E), // Dialog background color
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    title: Text(
                                                      'Select Arrival City',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    children: [
                                                      SimpleDialogOption(
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              'Colombo');
                                                        },
                                                        child: Text(
                                                          'Colombo',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                      ),
                                                      SimpleDialogOption(
                                                        onPressed: () {
                                                          Navigator.pop(context,
                                                              'Batticaloa');
                                                        },
                                                        child: Text(
                                                          'Batticaloa',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white70),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                if (selected != null) {
                                                  setState(() {
                                                    toCity =
                                                        selected as String?;
                                                  });
                                                }
                                              },
                                              child: InputDecorator(
                                                decoration: InputDecoration(
                                                  labelText: 'To',
                                                  labelStyle: TextStyle(
                                                      color: Colors.white),
                                                  filled: true,
                                                  fillColor: Color(
                                                      0xFF00113E), // Background color of the input field
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  prefixIcon: Icon(
                                                    Icons.location_on_outlined,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                child: Text(
                                                  toCity ??
                                                      'Select Arrival City',
                                                  style: TextStyle(
                                                    color: toCity == null
                                                        ? Colors.grey
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () =>
                                                  _selectDate(context),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    21, 241, 241, 241),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                minimumSize:
                                                    Size(double.infinity, 50),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.date_range,
                                                    color: Colors.white,
                                                  ), // Icon
                                                  SizedBox(
                                                      width:
                                                          8), // Space between icon and text
                                                  Text(
                                                    selectedDate == null
                                                        ? 'Select Date'
                                                        : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height:
                                              16), // Space between the two rows
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () => _search(context),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFFFF8811),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                minimumSize:
                                                    Size(double.infinity, 50),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.search,
                                                    color: Colors.white,
                                                  ), // Icon
                                                  SizedBox(
                                                      width:
                                                          8), // Space between icon and text
                                                  Text('Search',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
