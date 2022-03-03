import 'package:PhoneAuth/services/authenticate.dart';
import 'package:PhoneAuth/utils/app_color.dart';
import 'package:PhoneAuth/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

/// The screen for input verification code
/// Made up of three main components: title, form, bottom part

class SmsScreen extends StatefulWidget {
  final String verificationId;

  const SmsScreen({Key key, this.verificationId}) : super(key: key);
  @override
  _SmsScreenState createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final _smsController = TextEditingController();
  void fetchOtp() {
    print('setState fetchOtp');
  }

  @override
  void initState() {
    // print('This is verification id ${widget.verificationId}');
    _listenOTP();
    fetchOtp();
    super.initState();
  }

  void _listenOTP() async {
    await SmsAutoFill().listenForCode;
  }

  validateOtp(String otp) {
    print('Code received $otp');
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 30, bottom: 60),
        child: Column(
          children: [
            title(),
            SizedBox(height: 50),
            form(),
            Spacer(),
            bottom(),
          ],
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter the code ',
            style: TextStyle(fontSize: 25),
          ),
          Text(
            'Please enter the code sent to +61 63487 23342 to continue.',
            style: TextStyle(fontSize: 16, color: Color(0xff899386)),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        // Container(
        //   width: 330,
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(8),
        //   ),
        //   child: Form(
        //     child: TextFormField(
        //       textAlign: TextAlign.center,
        //       controller: _smsController,
        //       autocorrect: false,
        //       autofocus: false,
        //       decoration: InputDecoration(
        //         hintText: '••••',
        //         hintStyle: TextStyle(
        //           fontSize: 20,
        //         ),
        //         border: InputBorder.none,
        //       ),
        //       keyboardType: TextInputType.number,
        //       style: TextStyle(
        //           fontSize: 25,
        //           color: Colors.black,
        //           fontWeight: FontWeight.w400),
        //     ),
        //   ),
        // ),
        PinFieldAutoFill(
          keyboardType: TextInputType.number,
          cursor: Cursor(color: Colors.black, enabled: true, width: 1),
          autoFocus: true,
          controller: _smsController,
          codeLength: 6,
          currentCode: "",
          decoration: BoxLooseDecoration(
              textStyle: TextStyle(color: Colors.black),
              radius: Radius.circular(1),
              strokeColorBuilder: FixedColorBuilder(Colors.black)),
          onCodeChanged: (pin) {
            if (pin.length == 6) {
              // signInWithPhoneNumber(pin);
            }
          },
        ),
        SizedBox(height: 15.0),
        Text(
          'Didnt receive it? Tap to resend.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget bottom() {
    return Column(
      children: [
        SizedBox(height: 30),
        RoundedButton(
          color: AppColor.AccentBlue,
          minimumWidth: 230,
          disabledColor: AppColor.AccentBlue.withOpacity(0.3),
          onPressed: () {
            AuthService().signInWithOTP(
                context, _smsController.text, widget.verificationId);
          },
          child: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Icon(Icons.arrow_right_alt, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
