import 'package:flutter/material.dart';

class Available extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // height: heightSize,
              // width: ticketWidth,
              color: Colors.white, // Set the background color to white
              child: Stack(children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListView.builder(
                                itemCount: 1,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  bool _isRunning = false;
                                  return GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 1),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "UNKNOWN",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 48,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "UNKNOWN",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          right: 0,
                                                          bottom: 0,
                                                          top: 0,
                                                          left: 0,
                                                          child: Container(
                                                            height: 2,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        AnimatedPositioned(
                                                          right: 0,
                                                          bottom: 0,
                                                          top: 0,
                                                          left: 0,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  150),
                                                          child: RotatedBox(
                                                            quarterTurns: 0,
                                                            child: Icon(
                                                              Icons
                                                                  .directions_bus_filled_outlined,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 0,
                                                          bottom: 0,
                                                          top: 0,
                                                          child: CircleAvatar(
                                                            radius: 4,
                                                            backgroundColor:
                                                                Colors.black,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 0,
                                                          bottom: 0,
                                                          top: 0,
                                                          child: CircleAvatar(
                                                            radius: 4,
                                                            backgroundColor:
                                                                Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "UNKNOWN",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "UNKNOWN",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              Text(
                                                "UNKNOWN",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 5),
                                          Text(
                                            "Bookings close on",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            "UNKNOWN",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "11.30 AM",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          ElevatedButton(
                                            onPressed: () {
                                              // Your onPressed function here
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(
                                                  0xFF00113E), // Background color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10), // Border radius
                                              ),
                                            ),
                                            child: Text(
                                              'Book Now',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CustomPaint(
                  painter: SideCutsDesign(),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                  ),
                ),
                CustomPaint(
                  painter: DottedInitialPath(),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                  ),
                ),
                CustomPaint(
                  painter: DottedMiddlePath(),
                  child: SizedBox(
                    height: 120,
                    width: double.infinity,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedMiddlePath extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 3;
    double dashSpace = 4;
    double startY = 10;
    final paint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 1;

    while (startY < size.height - 10) {
      canvas.drawCircle(Offset(size.width / 8, startY), 2, paint);
      startY += dashWidth + dashSpace;
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
        Rect.fromCircle(center: Offset(0, h / 2), radius: 18),
        0,
        10,
        false,
        Paint()
          ..style = PaintingStyle.fill
          ..color = commonColor);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(w / 8, h), radius: 7),
        0,
        10,
        false,
        Paint()
          ..style = PaintingStyle.fill
          ..color = commonColor);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(w / 8, 0), radius: 7),
        0,
        10,
        false,
        Paint()
          ..style = PaintingStyle.fill
          ..color = commonColor);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(0, h), radius: 7),
        0,
        10,
        false,
        Paint()
          ..style = PaintingStyle.fill
          ..color = commonColor);
    canvas.drawArc(
        Rect.fromCircle(center: const Offset(0, 0), radius: 7),
        0,
        10,
        false,
        Paint()
          ..style = PaintingStyle.fill
          ..color = commonColor);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(w, h), radius: 7),
        0,
        10,
        false,
        Paint()
          ..style = PaintingStyle.fill
          ..color = commonColor);
    canvas.drawArc(
        Rect.fromCircle(center: Offset(w, 0), radius: 7),
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
