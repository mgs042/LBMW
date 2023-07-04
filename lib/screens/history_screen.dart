import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trash_dash/screens/main_screen.dart';

import '../provider/auth_provider.dart';
import '../screens/user_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final String uid = ap.uid;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('pickupLocations');

    return Scaffold(
      backgroundColor: Color(0xffe4fbed),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Trash Dash",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff010402)),
        ),
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                FutureBuilder<DocumentSnapshot>(
                  future: _collectionRef.doc(uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Center(
                        child: Text('No data found for UID: $uid'),
                      );
                    }

                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;

                    final selectedWasteType = data['selectedWasteType'];
                    final address = data['address'];
                    final selectedDate = data['selectedDate'];
                    final formattedDate = DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(selectedDate));

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color(0xff8CEEB3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Date',
                                  style: TextStyle(
                                    color: Color(0xff010402),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    color: Color(0xff010402),
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color(0xff8CEEB3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(16),
                            margin: EdgeInsets.only(bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Waste Type',
                                  style: TextStyle(
                                    color: Color(0xff010402),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  selectedWasteType,
                                  style: TextStyle(
                                    color: Color(0xff010402),
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color(0xff8CEEB3),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Address',
                                  style: TextStyle(
                                    color: Color(0xff010402),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  address,
                                  style: TextStyle(
                                    color: Color(0xff010402),
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                // Placeholder for another screen/widget
                Container(
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
            child: Container(
              width: 321,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffF2FDF6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconText(
                    icon: FontAwesomeIcons.solidCircleUser,
                    text: 'Account',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserScreen()),
                      );
                    },
                  ),
                  IconText(
                    icon: FontAwesomeIcons.clockRotateLeft,
                    text: 'History',
                    onPressed: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                  ),
                  IconText(
                    icon: FontAwesomeIcons.house,
                    text: 'Home',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                  ),
                  IconText(
                    icon: FontAwesomeIcons.gift,
                    text: 'Rewards',
                    onPressed: () {
                      // Handle Rewards button tap
                    },
                  ),
                ],
              ),
            ),
          )
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
