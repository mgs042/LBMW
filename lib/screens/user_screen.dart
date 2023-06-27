import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_dash/provider/auth_provider.dart';
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
      backgroundColor: Color(0xFF0F0F0F),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Trash Dash",
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
              icon: const Icon(Icons.exit_to_app),
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
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              ap.userModel.address,
              style: TextStyle(
                color: Colors.white,
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
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Orders',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.map,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Map',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.edit,
                      color: Colors.white,
                      size: 24,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Profile Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
            color: Colors.grey.shade900,
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
        Icon(
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
