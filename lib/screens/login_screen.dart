import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rpgl/bases/api/ownerLogin.dart';
import 'package:rpgl/bases/themes.dart';
import 'package:rpgl/screens/captainsRoom_screen.dart';
import 'package:rpgl/screens/ownersRoom_screen.dart';
import 'package:rpgl/screens/play_along_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isFromLogin;

  const LoginScreen({super.key, required this.isFromLogin});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());
  bool _showOtpField = false;
  String? _serverOtp;

  // Declare the response variable to store the API response
  late OwnerLoginAPI response;

  @override
  void initState() {
    super.initState();
    // Attempt to redirect to the OwnersRoomScreen if data is already saved locally
    // Retrieve the saved data from Hive and navigate
    if (widget.isFromLogin == true) {
      redirectToOwnersRoom();
    } else {
      redirectToPlayalongRoom();
    }
    // redirectToOwnersRoom();
  }

  Future<void> redirectToOwnersRoom() async {
    // Retrieve stored data from Hive
    OwnerLoginAPI? storedData = await OwnerLoginAPI.readDataLocally();

    if (storedData != null && storedData.participantData != null) {
      ParticipantData participantData = storedData.participantData!;

      // // Navigate to OwnersRoomScreen with stored data
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => OwnersRoomScreen(
      //       teamId: participantData.teamId ?? '',
      //       teamImage: participantData.teamImage ?? '',
      //       teamName: participantData.teamName ?? '',
      //       ownerName: participantData.memberName ?? '',
      //       ownerid: participantData.memberId ?? '',
      //       ownerimage: storedData.participantImage ?? '',
      //     ),
      //   ),
      // );
      // Navigate to OwnersRoomScreen with stored data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CaptainsRoomScreen(
            teamId: participantData.teamId ?? '',
            teamImage: participantData.teamImage ?? '',
            teamName: participantData.teamName ?? '',
            ownerName: participantData.memberName ?? '',
            ownerid: participantData.memberId ?? '',
            ownerimage: storedData.participantImage ?? '',
          ),
        ),
      );
    }
  }

  Future<void> redirectToPlayalongRoom() async {
    // Retrieve stored data from Hive
    OwnerLoginAPI? storedData = await OwnerLoginAPI.readDataLocally();

    if (storedData != null && storedData.participantData != null) {
      ParticipantData participantData = storedData.participantData!;

      // Navigate to OwnersRoomScreen with stored data
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => PlayAlongScreen(
      //         // teamId: participantData.teamId ?? '',
      //         // teamImage: participantData.teamImage ?? '',
      //         // teamName: participantData.teamName ?? '',
      //         // ownerName: participantData.memberName ?? '',
      //         // ownerid: participantData.memberId ?? '',
      //         // ownerimage: storedData.participantImage ?? '',
      //         ),
      //   ),
      // );
    }
  }

  Future<void> _sendOtp() async {
    final phoneNumber = _phoneNumberController.text;

    try {
      // Make the API call to get the OTP and user data
      response = await OwnerLoginAPI.ownerlist(phoneNumber);
      if (response.processStatus == 'YES') {
        // Successfully received the OTP
        setState(() {
          _showOtpField = true;
          _serverOtp = response.oTP;
        });
      } else {
        // Show an error if the process status is not 'YES'
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.processMessage ?? 'Error')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP: $e')),
      );
    }
  }

  void _submitOtp() async {
    final enteredOtp =
        _otpControllers.map((controller) => controller.text).join();

    if (enteredOtp == _serverOtp) {
      // Successful OTP match, save the data locally
      OwnerLoginAPI ownerLoginData = OwnerLoginAPI.fromJson(response.toJson());
      await OwnerLoginAPI.saveDataLocally(ownerLoginData);

      // Retrieve the saved data from Hive and navigate
      if (widget.isFromLogin == true) {
        redirectToOwnersRoom();
      } else {
        redirectToPlayalongRoom();
      }
      // redirectToOwnersRoom();
    } else {
      // Show error if OTP does not match
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              _showOtpField
                  ? 'We’ve sent an OTP to ${_phoneNumberController.text}'
                  : 'Please enter your phone number to continue.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24.0),
            if (!_showOtpField)
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                ),
                cursorColor: Colors.black,
              ),
            if (_showOtpField)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    child: TextField(
                      controller: _otpControllers[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                        counterText: '',
                      ),
                      maxLength: 1,
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          if (index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        } else if (value.length == 1) {
                          if (index < 3) {
                            FocusScope.of(context).nextFocus();
                          } else {
                            FocusScope.of(context).unfocus();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
            if (_showOtpField)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Resend OTP logic
                    _sendOtp();
                  },
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(color: AppThemes.getBackground()),
                  ),
                ),
              ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                if (!_showOtpField) {
                  _sendOtp(); // Send OTP logic
                } else {
                  _submitOtp(); // Submit OTP logic
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppThemes.getBackground(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
              ),
              child: Text(
                _showOtpField ? 'Submit OTP' : 'Send OTP',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Spacer(flex: 2),
            Center(
              child: Column(
                children: [
                  Text(
                    'Powered by',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Image.asset(
                    'assets/images/forcepower.jpg', // Replace with your logo asset path
                    height: 40.0,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
