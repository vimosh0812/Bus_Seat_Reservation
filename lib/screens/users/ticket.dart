import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:project1/screens/wrapper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketScreen extends StatefulWidget {
  final List<int> selectedSeats;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController nameController;
  final String scheduleDate;
  final String route;
  final String gender;
  final String month;

  const TicketScreen({
    Key? key,
    required this.selectedSeats,
    required this.emailController,
    required this.mobileController,
    required this.nameController,
    required this.scheduleDate,
    required this.route,
    required this.gender,
    required this.month,
  }) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int get listSize => widget.selectedSeats.length;
  List<int> get selectedSeats => widget.selectedSeats;
  String selectedSeatsTxt = '';
  String QrText = '';

  @override
  void initState() {
    super.initState();
    selectedSeatsTxt = 'Seat No: ${selectedSeats.join('-')}';
    QrText = widget.route + widget.scheduleDate + selectedSeatsTxt;
  }

  String? _qrData;

  Future<String> _generateJwt(String data) async {
    final payload = {'data': data};

    // Generate JWT
    final jwt = JWT(payload);
    final token =
        jwt.sign(SecretKey('RoyalExpress')); // Use your secret key here
    return token;
  }

  void _generateQRCode(String data) async {
    String token = await _generateJwt(data);
    setState(() {
      _qrData = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    _generateQRCode(QrText);
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade600,
        title: const Text(
          'Ticket Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Wrapper()));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Center(
            child: Container(
              width: width * 0.8,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('images/busx.jpg'),
                                ),
                              ),
                              height: 125,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Royal Express",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    widget.route,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Time : 10 PM",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    widget.scheduleDate,
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (widget.selectedSeats.length == 1) ...{
                                        Text(
                                          'Seat No: ${widget.selectedSeats[0]}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      } else if (widget.selectedSeats.length >
                                          1) ...{
                                        Text(
                                          'Seat No: ${widget.selectedSeats.join(', ')}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      },
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade600,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                "   Booked   ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomPaint(
                          painter: SideCutsDesign(),
                          child: Container(
                            height: 20,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: CustomPaint(
                          painter: DottedMiddlePathX(),
                          child: Container(
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Center(
                      child: Column(
                        children: [
                          Column(
                            children: [
                              if (_qrData != null && _qrData!.isNotEmpty)
                                Container(
                                  child: QrImageView(
                                    data: _qrData!,
                                    version: QrVersions.auto,
                                    size: 140.0,
                                  ),
                                ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 1,
                                width: width * 0.7,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Tickets ${listSize}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            // multiply the size of the selected seqts into 300

                                            (listSize * 3000).toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Convenience Fee",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            (listSize * 100).toString(),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    (listSize * 3100).toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DottedMiddlePath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    // double dashSpace = 4;
    double startY = size.height * (2 / 3);
    final paint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 0.1;

    while (startY < size.height - 1) {
      canvas.drawCircle(Offset(size.width / 5, startY), 2, paint);
      startY += dashWidth + 4;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DottedMiddlePathX extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double dashSpace = 4;
    double startX = 10;
    final paint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    while (startX < size.width - 5) {
      canvas.drawCircle(Offset(startX, 3 * size.height / 7), 2, paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DottedInitialPath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double dashSpace = 4;
    double startY = 10;
    final paint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    while (startY < size.height - 10) {
      canvas.drawCircle(Offset(0, startY), 2, paint);
      startY += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SideCutsDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var h = size.height;
    var w = size.width;
    var commonColor = Colors.grey.shade200;

    canvas.drawArc(
        Rect.fromCircle(center: Offset(0, 3 * h / 5), radius: 12),
        0,
        10,
        false,
        Paint()
          ..style = PaintingStyle.fill
          ..color = commonColor);

    canvas.drawArc(
        Rect.fromCircle(center: Offset(w, 3 * h / 5), radius: 12),
        0,
        10,
        false,
        Paint()
          ..style = PaintingStyle.fill
          ..color = commonColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
