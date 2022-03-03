import 'package:PhoneAuth/screens/homescreen/homescreen.dart';
import 'package:PhoneAuth/screens/phone/phone_screen.dart';
import 'package:PhoneAuth/screens/sms/sms_screen.dart';
import 'package:flutter/material.dart';

/// Generator callback allowing the app to be navigated to a named route.

/// Static class contains Strings of all named routes
class Routers {
  static const String home = '/home';
  static const String phone = '/phone';
  static const String sms = '/sms';
}

///Return MaterialPageRoute depends of route name

// ignore: missing_return
Route<dynamic> router(routeSetting) {
  switch (routeSetting.name) {
    case Routers.home:
      return new MaterialPageRoute(
        builder: (context) => HomeScreen(),
        settings: routeSetting,
      );
      break;
    case Routers.phone:
      return new MaterialPageRoute(
        builder: (context) => PhoneScreen(),
        settings: routeSetting,
      );
      break;
    case Routers.sms:
      return new MaterialPageRoute(
          builder: (context) => SmsScreen(
                verificationId: routeSetting.arguments,
              ),
          settings: routeSetting);
      break;
  }
}
