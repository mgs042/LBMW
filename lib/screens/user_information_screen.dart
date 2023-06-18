import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/custom_button.dart';

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

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      //name field
                      textField(
                        hintText: "John Smith",
                        icon: CupertinoIcons.person_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        controller: nameController,
                      ),
                      //email
                      textField(
                        hintText: "abc@example.com",
                        icon: CupertinoIcons.mail,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: emailController,
                      ),
                      //address
                      textField(
                        hintText: "Enter your address",
                        icon: CupertinoIcons.location,
                        inputType: TextInputType.streetAddress,
                        maxLines: 4,
                        controller: addressController,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: CustomButton(text: "Continue", onPressed: () {}),
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
}
