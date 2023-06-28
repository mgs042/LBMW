import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trash_dash/screens/user_screen.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:trash_dash/widgets/custom_button.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F0F0F),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          backgroundColor: Colors.greenAccent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.black),
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
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Schedule a pick up at your time!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 360,
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 60,
              initialSelectedDate: DateTime.now(),
              selectedTextColor: Colors.greenAccent,
              dateTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              dayTextStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              monthTextStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
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
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          WasteContainer(),
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
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle the click event
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        Text(
                          'Edit Address',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.white,
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
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 40),
          SizedBox(
              width: 150,
              height: 37,
              child: ScheduleButton(onPressed: () {}, text: "Schedule"))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 30),
        child: Container(
          width: 321,
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade900,
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
              IconText(
                icon: FontAwesomeIcons.house,
                text: 'Home',
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
    color: Colors.white,
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
          color: Colors.greenAccent,
          size: 20,
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class WasteContainer extends StatefulWidget {
  @override
  _WasteContainerState createState() => _WasteContainerState();
}

class _WasteContainerState extends State<WasteContainer> {
  bool isOrganicSelected = false;
  bool isInorganicSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 350,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
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
                  setState(() {
                    isOrganicSelected = !isOrganicSelected;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: isOrganicSelected
                            ? Colors.greenAccent
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Organic Waste',
                      style: TextStyle(
                        color: Colors.white,
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
                  setState(() {
                    isInorganicSelected = !isInorganicSelected;
                  });
                },
                child: Row(
                  children: [
                    Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: isInorganicSelected
                            ? Colors.greenAccent
                            : Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Inorganic Waste',
                      style: TextStyle(
                        color: Colors.white,
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
