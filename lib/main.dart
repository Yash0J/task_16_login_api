import 'package:flutter/material.dart';

import 'utils/constants/colors.dart';
import 'sreens/auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColors.primaryColor,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primaryColor,
          background: AppColors.darkBlue,
          secondary: AppColors.purple,
        ),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
