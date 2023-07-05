import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trash_dash/screens/main_screen.dart';
import 'package:trash_dash/screens/payment_screen.dart';
import 'package:trash_dash/screens/user_screen.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:provider/provider.dart';
import 'package:trash_dash/provider/auth_provider.dart';
import 'package:intl/intl.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  DateTime selectedDate = DateTime.now(); // Variable to store the selected date
  String selectedWasteType = ''; // Variable to store the selected waste type
  String address = '';
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    address =
        Provider.of<AuthProvider>(context, listen: false).userModel.address;
  }

  @override
  void initState() {
    super.initState();
    selectedWasteType = 'Organic Waste';
  }

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffe4fbed),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Color(0xff8CEEB3),
          elevation: 0,
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.bell, color: Color(0xff010402)),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Color(0xff010402)),
              onPressed: () {
                // Handle hamburger menu tap
              },
            ),
          ],
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(left: 26, bottom: 11),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Schedule a Pick Up',
                  style: TextStyle(
                    color: Color(0xff010402),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Schedule a pick up at your time!',
                  style: TextStyle(
                    color: Color(0xff010402),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 360,
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 60,
                selectionColor: Color(0xffF2FDF6),
                selectedTextColor: Color(0xff8CEEB3),
                dateTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff010402)),
                dayTextStyle: TextStyle(
                    fontWeight: FontWeight.w500, color: Color(0xff010402)),
                monthTextStyle: TextStyle(
                    fontWeight: FontWeight.w500, color: Color(0xff010402)),
                onDateChange: (date) {
                  setState(() {
                    selectedDate =
                        date; // Update the selectedDate when the date changes
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 4,
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xff8CEEB3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 26),
              child: Align(
                alignment: Alignment.centerLeft, // Align text to the left
                child: Text(
                  'Garbage category',
                  style: TextStyle(
                    color: Color(0xff010402),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            WasteContainer(
              selectedWasteType: selectedWasteType,
              onWasteTypeSelected: (wasteType) {
                setState(() {
                  selectedWasteType = wasteType;
                  // Print the selected waste type
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 26),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pick Up Address',
                        style: TextStyle(
                          color: Color(0xff010402),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        children: [
                          Text(
                            'Edit Address',
                            style: TextStyle(
                              color: Color(0xff010402),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Icon(
                            Icons.edit,
                            color: Color(0xff010402),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 130,
              width: 350,
              decoration: BoxDecoration(
                color: Color(0xffF2FDF6),
                border: Border.all(
                  color: Color(
                      0xff8CEEB3), // Replace with your desired border color
                  width: 0.5, // Replace with your desired border width
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  ap.userModel.address,
                  style: TextStyle(
                      color: Color(0xff010402),
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 150,
              height: 37,
              child: ScheduleButton(
                onPressed: () {
                  final formattedDate =
                      DateFormat('yyyy-MM-dd').format(selectedDate);
                  final parsedDate = DateTime.parse(formattedDate);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        selectedDate: parsedDate,
                        selectedWasteType: selectedWasteType,
                        address: address,
                      ),
                    ),
                  );
                },
                text: 'Schedule',
                selectedDate: selectedDate,
                selectedWasteType: selectedWasteType,
                address: address,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 30),
        child: Container(
          width: 321,
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color:
                  Color(0xff8CEEB3), // Replace with your desired border color
              width: 0.5, // Replace with your desired border width
            ),
            color: Color(0xffF2FDF6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserScreen()));
                },
                child: IconText(
                  icon: FontAwesomeIcons.solidCircleUser,
                  text: 'Account',
                ),
              ),
              IconText(
                icon: FontAwesomeIcons.clockRotateLeft,
                text: 'History',
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: IconText(
                  icon: FontAwesomeIcons.house,
                  text: 'Home',
                ),
              ),
              IconText(
                icon: FontAwesomeIcons.gift,
                text: 'Rewards',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextStyle get subHeadingStyle {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xff010402),
  );
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconText({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          icon,
          color: Color(0xff8CEEB3),
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            color: Color(0xff010402),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class WasteContainer extends StatefulWidget {
  final String selectedWasteType;
  final Function(String) onWasteTypeSelected;

  const WasteContainer({
    Key? key,
    this.selectedWasteType = 'Organic Waste',
    required this.onWasteTypeSelected,
  }) : super(key: key);

  @override
  _WasteContainerState createState() => _WasteContainerState();
}

class _WasteContainerState extends State<WasteContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 350,
      decoration: BoxDecoration(
        color: Color(0xffF2FDF6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Color(0xff8CEEB3), // Replace with your desired border color
          width: 0.5, // Replace with your desired border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Organic Waste section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  widget.onWasteTypeSelected('Organic Waste');
                },
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: widget.selectedWasteType == 'Organic Waste'
                            ? Color(0xff8CEEB3)
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Organic Waste',
                      style: TextStyle(
                        color: Color(0xff010402),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Inorganic Waste section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  widget.onWasteTypeSelected('Inorganic Waste');
                },
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: widget.selectedWasteType == 'Inorganic Waste'
                            ? Color(0xff8CEEB3)
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Inorganic Waste',
                      style: TextStyle(
                        color: Color(0xff010402),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScheduleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final DateTime selectedDate;
  final String selectedWasteType;
  final String address;

  const ScheduleButton({
    required this.onPressed,
    required this.text,
    required this.selectedDate,
    required this.selectedWasteType,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(
              selectedDate: selectedDate,
              selectedWasteType: selectedWasteType,
              address: address,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xff8CEEB3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xff010402),
        ),
      ),
    );
  }
}
