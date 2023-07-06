import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_dash/screens/request_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trash_dash/screens/user_screen.dart';
import 'package:trash_dash/screens/welcome_screen.dart';
import 'package:trash_dash/screens/history_screen.dart';
import '../provider/auth_provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffe4fbed),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    ),
                  );
            },
            icon: const Icon(Icons.exit_to_app, color: Color(0xff010402)),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25, 50, 25, 0),
            child: Container(
              width: 333,
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color(0xffF2FDF6),
                border: Border.all(color: Color(0xff8CEEB3)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 101, 129, 113)
                        .withOpacity(1), // Shadow color
                    offset: Offset(5, 5), // Shadow position
                    blurRadius: 4, // Shadow blur radius
                    // Shadow spread radius
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'We deal with this world as if we had a second one in the trunk.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xff010402),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Image.asset('assets/SavetheEarth-bro.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Color(0xff8CEEB3),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 16, top: 26),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Waste Delivery',
                                    style: TextStyle(
                                      color: Color(0xff010402),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          8), // Add spacing between the texts
                                  Text(
                                    'Request for Delivery',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 62, 62),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child: Image.asset(
                                  'assets/Schedule.png',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 16, 25, 0),
            child: Text(
              'More Services',
              style: TextStyle(
                color: Color(0xff010402),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 16, 25, 10),
              child: Row(
                children: [
                  RoundedBox(
                    icon: FontAwesomeIcons.moneyCheckDollar,
                    text: 'Earn Money',
                  ),
                  SizedBox(width: 16),
                  RoundedBox(
                    icon: FontAwesomeIcons.houseCircleCheck,
                    text: 'Smart Bin',
                  ),
                  SizedBox(width: 16),
                  RoundedBox(
                    icon: FontAwesomeIcons.recycle,
                    text: 'Recycle',
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 25, 30),
              child: Container(
                width: 321,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(
                        0xff8CEEB3), // Replace with your desired border color
                    width: 0.5, // Replace with your desired border width
                  ),
                  color: const Color(0xffF2FDF6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconText(
                      icon: FontAwesomeIcons.solidCircleUser,
                      text: 'Account',
                      onPressed: () => navigateToUserPage(context),
                    ),
                    IconText(
                      icon: FontAwesomeIcons.clockRotateLeft,
                      text: 'History',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryScreen()),
                        );
                      },
                    ),
                    IconText(
                      icon: FontAwesomeIcons.house,
                      text: 'Home',
                      onPressed: () {},
                    ),
                    IconText(
                      icon: FontAwesomeIcons.gift,
                      text: 'Rewards',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToUserPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserScreen()),
    );
  }
}

class RoundedBox extends StatelessWidget {
  final IconData icon;
  final String text;

  const RoundedBox({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 101,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xff8CEEB3),
        ),
        color: Color(0xffF2FDF6),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 101, 129, 113)
                .withOpacity(1), // Shadow color
            offset: Offset(5, 5), // Shadow position
            blurRadius: 4, // Shadow blur radius
            // Shadow spread radius
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: Color(0xff8CEEB3),
          ),
          SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff010402),
            ),
          ),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const IconText({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MainScreen(),
  ));
}
