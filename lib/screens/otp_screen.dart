import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:trash_dash/screens/main_screen.dart';
import 'package:trash_dash/screens/user_information_screen.dart';
import 'package:trash_dash/utils/utils.dart';
import 'package:trash_dash/widgets/custom_button.dart';
import '../provider/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? otpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 74, 189, 78),
                ),
              )
            : Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back, size: 30.0),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade900,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset('assets/image2.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Enter the OTP sent to your phone number",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(0, 133, 7, 1),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 0, 137, 5),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(196, 248, 193, 0.212),
                                offset: Offset(0, 3),
                                blurRadius: 1,
                              )
                            ],
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 83, 181, 86),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 6, 156, 34),
                          ),
                        ),
                        errorPinTheme: PinTheme(
                          width: 50,
                          height: 50,
                          textStyle: const TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 207, 6, 6),
                          ),
                        ),
                        onCompleted: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 55),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          text: "Verify",
                          onPressed: () {
                            if (otpCode != null) {
                              verifyOtp(context, otpCode!);
                            } else {
                              showSnackBar(context, "Enter 6-digit code");
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 60),
                      const Text(
                        "Didn't receive any code?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

//verify otp
  void verifyOtp(BuildContext context, String userOtp) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    ap.verifyOtp(
      context: context,
      verificationId: widget.verificationId,
      userOtp: userOtp,
      onSuccess: () {
        //checking wether user exists in the db
        ap.checkExistingUser().then(
          (value) async {
            if (value == true) {
              //user exists in our app
              ap.getDataFromFirestore().then(
                    (value) => ap.saveUserDataToSP().then(
                          (value) => ap.setSignIn().then(
                                (value) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()),
                                    (route) => false),
                              ),
                        ),
                  );
            } else {
              //new user
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserInformationScreen()),
                  (route) => false);
            }
          },
        );
      },
    );
  }
}
