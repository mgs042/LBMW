import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:trash_dash/model/user_model.dart';
import 'package:trash_dash/screens/home_screen.dart';
import 'package:trash_dash/screens/map_screen.dart';
import 'package:trash_dash/provider/auth_provider.dart';
import 'package:trash_dash/utils/utils.dart';
import 'package:trash_dash/widgets/custom_button.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  LatLng? _selectedLocation;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
  }

  // For selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  // Open the map screen to select location
  void openMapScreen() async {
    final selectedLocation = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(builder: (context) => MapScreen()),
    );

    if (selectedLocation != null) {
      setState(() {
        _selectedLocation = selectedLocation;
        // Reverse geocode the selected location to get the address
        _updateAddressFromLocation();
      });
    }
  }

  // Reverse geocode the selected location to get the address
  void _updateAddressFromLocation() async {
    try {
      final addresses = await placemarkFromCoordinates(
        _selectedLocation!.latitude,
        _selectedLocation!.longitude,
        localeIdentifier:
            'en_US', // Specify the desired language for the address
      );

      if (addresses.isNotEmpty) {
        final address = addresses.first;
        final formattedAddress =
            "${address.street}, ${address.locality}, ${address.country}";
        addressController.text = formattedAddress;
      }
    } catch (e) {
      print('Error updating address: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 74, 189, 78),
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => selectImage(),
                        child: image == null
                            ? const CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 50,
                                child: Icon(
                                  CupertinoIcons.person_circle,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 50,
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            // Name field
                            textField(
                              hintText: "Enter your name",
                              icon: CupertinoIcons.person_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: nameController,
                            ),
                            // Email
                            textField(
                              hintText: "Enter your email",
                              icon: CupertinoIcons.mail,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: emailController,
                            ),
                            // Address
                            textField(
                              hintText: "Enter your address",
                              icon: CupertinoIcons.location,
                              inputType: TextInputType.streetAddress,
                              maxLines: 4,
                              controller: addressController,
                              enabled: true, // Enable editing of address field
                              suffixIcon: IconButton(
                                icon: Icon(Icons.map),
                                onPressed: openMapScreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: () => storeData(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    bool enabled = true,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          TextFormField(
            cursorColor: Colors.green,
            controller: controller,
            keyboardType: inputType,
            maxLines: maxLines,
            enabled: enabled,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(40, 10, 15, 10),
              hintText: hintText,
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.green,
                ),
              ),
              suffixIcon: suffixIcon,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              width: 45,
              height: 45,
              child: Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.green,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Store user data to the database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        address: addressController.text.trim(),
        profilePic: "",
        createdAt: "",
        phoneNumber: "",
        uid: "",
        latitude: _selectedLocation!.latitude,
        longitude: _selectedLocation!.longitude);

    if (image != null) {
      // Save user data to Firebase
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          // Once data is saved, store it locally
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false,
                      ),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
}
