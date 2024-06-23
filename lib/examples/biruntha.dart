import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BusBookingSelectPagey extends StatefulWidget {
  const BusBookingSelectPagey({Key? key}) : super(key: key);

  @override
  State<BusBookingSelectPagey> createState() => _BusBookingSelectPageState();
}

class _BusBookingSelectPageState extends State<BusBookingSelectPagey> {
  int _selectedSeats = 1;
  bool _wantsLadiesSeat = false;
  int _selectedLadiesSeats = 0;
  List<int> _selectedLadiesSeatIndexes = [];
  Set<int> _selectedSeatIndexes = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSeatsDialog(context);
    });
  }

  void _showSeatsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'How many seats?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _selectedSeats = index + 1;
                        });
                        Navigator.of(context).pop();
                        _showLadiesSeatDialog(context);
                      },
                      child: Text('${index + 1}'),
                      heroTag: 'seats_${index + 1}',
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLadiesSeatDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Would you like a ladies seat?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _wantsLadiesSeat = true;
                      });
                      Navigator.of(context).pop();
                      _showLadiesSeatsCountDialog(context);
                    },
                    child: Text('Yes'),
                    heroTag: 'ladies_yes',
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _wantsLadiesSeat = false;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                    heroTag: 'ladies_no',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLadiesSeatsCountDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How many ladies seats are required?',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_selectedSeats, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _selectedLadiesSeats = index + 1;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('${index + 1}'),
                      heroTag: 'ladies_seats_${index + 1}',
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleLadiesSeat(int index) {
    setState(() {
      if (_selectedLadiesSeatIndexes.contains(index)) {
        _selectedLadiesSeatIndexes.remove(index);
      } else if (_selectedLadiesSeatIndexes.length < _selectedLadiesSeats) {
        _selectedLadiesSeatIndexes.add(index);
      }
    });
  }

  void _toggleSeat(int index) {
    setState(() {
      if (_selectedSeatIndexes.contains(index)) {
        _selectedSeatIndexes.remove(index);
      } else if (_selectedSeatIndexes.length < _selectedSeats) {
        _selectedSeatIndexes.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
      appBar: AppBar(
        title: const Text("Select your seats"),
        titleTextStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.pop();
          },
          color: Colors.grey,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
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
                  padding: const EdgeInsets.all(42.0),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "01",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "02",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "03",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '04',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          _LadiesSeatComponent(
                            title: '05',
                            isEnabled: _wantsLadiesSeat,
                            isSelected: _selectedLadiesSeatIndexes.contains(3),
                            onTap: () => _toggleLadiesSeat(3),
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "06",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "07",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '08',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "09",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "10",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "11",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '12',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "13",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "14",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "15",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '16',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "17",
                            marginRight: 10,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "18",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _TakenSeatComponent(
                            marginRight: 10,
                            text: '19',
                          ),
                          _TakenSeatComponent(
                            text: '20',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "21",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            text: '22',
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "23",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "24",
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _TakenSeatComponent(
                            marginRight: 16,
                            text: '25',
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "26",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _TakenSeatComponent(
                            marginRight: 16,
                            text: '27',
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '28',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _TakenSeatComponent(
                            marginRight: 16,
                            text: '29',
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '30',
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "31",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "32",
                            marginRight: 0,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "33",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "34",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "35",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '36',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "37",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "38",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "39",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '40',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "41",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "42",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "43",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '44',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "45",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "46",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "47",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '48',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "49",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "50",
                            marginRight: 0,
                          ),
                          Spacer(),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "51",
                            marginRight: 16,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '52',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: const [
                          _SelectedSeatComponent(
                            text: "53",
                            marginRight: 16,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "54",
                            marginRight: 4,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "55",
                            marginRight: 4,
                          ),
                          _GeneralSeatComponent(
                            borderColor: Colors.black,
                            title: "56",
                            marginRight: 8,
                          ),
                          _TakenSeatComponent(
                            marginRight: 0,
                            text: '57',
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
      bottomNavigationBar: SizedBox(
        height: 150,
        child: BottomAppBar(
          elevation: 64,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Ladies Seat",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Selected Seat",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Booked Seat",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Counter Seats",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "Available Seat",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  height: 34,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 31, 56),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Center(
                    child: Text(
                      "Proceed",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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

class _TakenSeatComponent extends StatelessWidget {
  const _TakenSeatComponent({
    Key? key,
    this.marginRight = 0.0,
    required this.text,
  }) : super(key: key);

  final double? marginRight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: marginRight ?? 0),
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.black), // Add black border
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white, // Assuming white text for better contrast
            fontSize: 16, // Adjust the size as needed
          ),
        ),
      ),
    );
  }
}

class SeatSelectionScreen extends StatefulWidget {
  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Selection'),
      ),
      body: Center(
        child: _GeneralSeatComponent(
          title: 'A1',
          borderColor: Colors.black,
          marginRight: 8.0,
        ),
      ),
    );
  }
}

class _GeneralSeatComponent extends StatefulWidget {
  final String? title;
  final Color borderColor;
  final double? marginRight;

  const _GeneralSeatComponent({
    Key? key,
    this.title,
    this.borderColor = Colors.black,
    this.marginRight = 0.0,
  }) : super(key: key);

  @override
  _GeneralSeatComponentState createState() => _GeneralSeatComponentState();
}

class _GeneralSeatComponentState extends State<_GeneralSeatComponent> {
  bool isSelected = false;

  void _toggleSeat() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return _SelectedSeatComponent(
        text: widget.title ?? '',
        marginRight: widget.marginRight,
      );
    }

    return GestureDetector(
      onTap: _toggleSeat,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        margin: EdgeInsets.only(
          right: widget.marginRight ?? 0,
        ),
        child: Center(
          child: Text(
            "${widget.title}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedSeatComponent extends StatefulWidget {
  const _SelectedSeatComponent({
    Key? key,
    this.marginRight = 0.0,
    required this.text,
  }) : super(key: key);

  final double? marginRight;
  final String text;

  @override
  _SelectedSeatComponentState createState() => _SelectedSeatComponentState();
}

class _SelectedSeatComponentState extends State<_SelectedSeatComponent> {
  bool isGeneral = false;

  void _toggleSeat() {
    setState(() {
      isGeneral = !isGeneral;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isGeneral) {
      return _GeneralSeatComponent(
        marginRight: widget.marginRight,
        title: widget.text,
      );
    }

    return GestureDetector(
      onTap: _toggleSeat,
      child: Container(
        margin: EdgeInsets.only(right: widget.marginRight ?? 0),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black), // Black border
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white, // Assuming white text for better contrast
              fontSize: 16, // Adjust the size as needed
            ),
          ),
        ),
      ),
    );
  }
}

class _CounterSeatComponent extends StatelessWidget {
  const _CounterSeatComponent({
    Key? key,
    this.marginRight = 0.0,
    required this.text,
  }) : super(key: key);

  final double? marginRight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: marginRight ?? 0),
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.orange,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _LadiesSeatComponent extends StatefulWidget {
  final String title;
  final Color borderColor;

  const _LadiesSeatComponent({
    Key? key,
    this.marginRight = 0.0,
    required this.title,
    this.borderColor = Colors.black,
    required this.isEnabled,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final double? marginRight;
  final bool isEnabled;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  _LadiesSeatComponentState createState() => _LadiesSeatComponentState();
}

class _LadiesSeatComponentState extends State<_LadiesSeatComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled ? widget.onTap : null,
      child: Container(
        margin: EdgeInsets.only(right: widget.marginRight ?? 0),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.green : Colors.purple,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
