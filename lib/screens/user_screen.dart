import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_dash/provider/auth_provider.dart';
import 'package:trash_dash/screens/history_screen.dart';
import 'package:trash_dash/screens/main_screen.dart';
import 'package:trash_dash/screens/welcome_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xffe4fbed),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Trash Dash",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff010402)),
          ),
          actions: [
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
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 85),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => EnlargedImageDialog(
                    image: NetworkImage(ap.userModel.profilePic),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 150),
                child: Container(
                  padding: EdgeInsets.all(4),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(ap.userModel.profilePic),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              ap.userModel.name,
              style: TextStyle(
                color: Color(0xff010402),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              ap.userModel.address,
              style: TextStyle(
                color: Color(0xff010402),
                fontSize: 16,
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
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.fileAlt,
                      color: Color(0xff8CEEB3),
                      size: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Orders',
                      style: TextStyle(
                        color: Color(0xff010402),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.map,
                      color: Color(0xff8CEEB3),
                      size: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Map',
                      style: TextStyle(
                        color: Color(0xff010402),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.edit,
                      color: Color(0xff8CEEB3),
                      size: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Profile Edit',
                      style: TextStyle(
                        color: Color(0xff010402),
                        fontSize: 12,
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
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 30),
        child: Container(
          width: 321,
          height: 68,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xff8CEEB3),
              width: 0.5,
            ),
            color: Color(0xffF2FDF6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/account');
                },
                child: IconText(
                  icon: FontAwesomeIcons.solidCircleUser,
                  text: 'Account',
                  onPressed: () {},
                ),
              ),
              IconText(
                icon: FontAwesomeIcons.clockRotateLeft,
                text: 'History',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(),
                    ),
                  );
                },
              ),
              IconText(
                icon: FontAwesomeIcons.house,
                text: 'Home',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                },
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

class EnlargedImageDialog extends StatelessWidget {
  final ImageProvider image;

  const EnlargedImageDialog({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Image(image: image),
      ),
    );
  }
}
