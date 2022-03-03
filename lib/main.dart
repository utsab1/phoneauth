import 'package:PhoneAuth/services/authenticate.dart';
import 'package:PhoneAuth/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'utils/router.dart';

void main() => runApp(MyApp());

/// This widget is the root of application
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'phoneauth',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.LightBrown,
        appBarTheme: AppBarTheme(
          color: AppColor.LightBrown,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: AuthService().handleAuth(),
    );
  }
}
