import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../widgets/custom_button.dart';
import 'main_screen.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  final DateTime selectedDate;
  final String selectedWasteType;
  final String address;

  const PaymentScreen({
    required this.selectedDate,
    required this.selectedWasteType,
    required this.address,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    final DateTime selectedDate = widget.selectedDate;
    final String selectedWasteType = widget.selectedWasteType;
    final String address = widget.address;

    final ap = Provider.of<AuthProvider>(context, listen: false);
    final String uid = ap.uid;
    final double? latitude = ap.userModel.latitude;
    final double? longitude = ap.userModel.longitude;

    // Call the addPickupLocation function and pass the data to it

    ap
        .addPickupLocation(
      latitude!,
      longitude!,
      uid,
      address,
      selectedDate,
      selectedWasteType,
    )
        .then((_) {
      // Show a dialog to display the success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Your Trash Pickup request has been accepted.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Pop the dialog
                  Navigator.of(context).pop();
                  // Navigate to the HomeScreen
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      // Handle any error that occurred during data addition
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add pickup location. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Pop the dialog
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Payment failed, handle the failure case here
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle when an external wallet was selected
  }

  void _openRazorpayPayment() {
    var options = {
      'key': 'rzp_test_C3X9BCyefNLSXb',
      'amount': 5000, // Amount in paise (e.g., 5000 paise = Rs. 50)
      'name': 'Trash Dash',
      'description': 'Payment for waste disposal',
      'prefill': {
        'contact': '6235628120',
        'email': 'test@razorpay.com',
      },
    };

    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.5;
    double containerWidth = MediaQuery.of(context).size.width * 0.8;

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
                  'Confirm the Schedule',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Verify your details and pay',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: containerHeight,
              width: containerWidth,
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.001),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Confirm',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: Colors.greenAccent,
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Address:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.address,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Selected Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      DateFormat('yyyy-MM-dd').format(widget.selectedDate),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Selected Waste Type:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.selectedWasteType,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 60,
              child: CustomButton(
                text: "Pay Now",
                onPressed: _openRazorpayPayment,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
