import 'package:flutter/material.dart';
import 'package:trash_dash/screens/register_screen.dart';
import 'package:trash_dash/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:trash_dash/provider/auth_provider.dart';
import 'package:trash_dash/screens/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image1.png",
                  height: 300,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Let's get started",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '"The greatest threat to our planet is the belief that someone else will save it." - Robert Swan',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 32, 113, 37),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: CustomButton(
                      onPressed: () {
                        ap.isSignedIn ==
                                true //when true then fetch shared preference data
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                      },
                      text: "Get started",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
