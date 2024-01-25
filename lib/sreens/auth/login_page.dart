import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/constants/colors.dart';
import '../../utils/shared/coustom_widgits.dart';
import '../home/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ///
  /// [Validator for username.]
  String? validateUsername(username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    }

    return null; // Username is valid
  }

  ///
  /// [Validator for email.]
  String? validateEmail(email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    // Check if the email contains '@' and '.'
    else if (!RegExp(r'^[^@]+@[^.]+\..+$').hasMatch(email)) {
      return 'Invalid email format';
    }

    return null; // Email is valid
  }

  ///
  /// [Validator for password.]
  String? validatePassword(password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    return null; // Password is valid
  }

///////////////////////////////////////////////////////
  ///[ appling API for post->api]
  void login(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://reqres.in/api/login'),

        ///[login api integraded]

        body: {
          //
          /// 'email': 'eve.holt@reqres.in',
          'email': email,

          ///[getting email]

          /// 'password': 'pistol',
          'password': password,

          ///[getting password]
        },
      );

      String body = response.body;

      /// [assigning body as body response]

      if (response.statusCode == 200) {
        ///[200 status code is for success]
        // print('Account created successfully');
        var data = jsonDecode(body.toString());

        ///[getting body data from api and decodeing it from json to dart and storing it to  variable 'data']
        print("token for login is: ${data['token']}");

        ///[printing token in json data ]
        print('login successfully');
      } else {
        print('Login failed, status_code => ${response.statusCode}');

        ///[printing ststus-code for checking if it getting another one except 200, if it is getting one!]
      }
    } catch (catchError) {
      print(catchError.toString());

      ///[printing error, if it is getting one!]
    }
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _usernameError;
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;

    var mediaHeight = MediaQuery.of(context).size.height;

    //
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.darkBlue,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                const SizedBox(height: 18),
                //
                loginImage(mediaHeight),
                //
                const SizedBox(height: 36),
                // const SizedBox(height: 18),
                //
                Coustom.text(
                  text: "Login",
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  // textAlign: TextAlign.left,
                ),
                //
                const SizedBox(height: 12),
                //
                Coustom.text(
                  text: "Please sign in to continue",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  // textAlign: TextAlign.left,
                ),
                //
                const SizedBox(height: 38),
                //
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      userNameTextField(),
                      //
                      emailTextField(),
                      //
                      passwordTextField(),
                    ],
                  ),
                ),
                //
                const SizedBox(height: 6),
                //
                loginButton(mediaWidth),
                //
                forgotPasswordButton(mediaWidth),
                //
                // SizedBox(height: mediaHeight * 0.1),

                //
                newAccountSignup(),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
  Center loginImage(double mediaHeight) {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/undraw_login.svg',
        height: mediaHeight * 0.18,
      ),
    );
  }

  SizedBox userNameTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Coustom.textField(
            validator: (value) {
              setState(() {
                _usernameError = validateUsername(value);
              });
              return null;
            },
            controller: _usernameController,
            cursorColor: AppColors.white,
            prefixIcon: const Icon(Icons.person), // Set the prefix icon
            hintText: 'Enter user name', // Placeholder text
            label: Coustom.text(
              text: "User Name",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (_usernameError != null)
            Text(
              _usernameError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  SizedBox emailTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Coustom.textField(
            validator: (value) {
              setState(() {
                _emailError = validateUsername(value);
              });
              return null;
            },
            controller: _emailController,
            cursorColor: AppColors.white,
            prefixIcon: const Icon(Icons.email_outlined), // Set the prefix icon
            hintText: 'Enter your email', // Placeholder text
            label: Coustom.text(
              text: "EMAIL",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (_emailError != null)
            Text(
              _emailError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  SizedBox passwordTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Coustom.textField(
            validator: (value) {
              setState(() {
                _passwordError = validateUsername(value);
              });
              return null;
            },
            controller: _passwordController,
            obscureText: true,
            hintText: 'Enter your password', // Placeholder text
            label: Coustom.text(
              text: "PASSWORD",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: AppColors.white,
            prefixIcon: const Icon(
              Icons.lock_outlined,
            ), // Set the prefix icon
          ),
          if (_passwordError != null)
            Text(
              _passwordError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  TextButton loginButton(double mediaWidth) {
    return TextButton(
      onPressed: () {
        // Validate the form
        if (_formKey.currentState?.validate() == true) {
          // Form is valid, perform login logic here
          // For demonstration purposes, we print the values
          print('Username: ${_usernameController.text}');
          print('Email: ${_emailController.text}');
          print('Password: ${_passwordController.text}');
        }
        login(_emailController.text.toString(),
            _passwordController.text.toString());
        Navigator.of(context as BuildContext)
            .push(MaterialPageRoute(builder: (context) => const HomePage()));
      },
      style: TextButton.styleFrom(
        backgroundColor: AppColors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
        minimumSize: Size(mediaWidth / 1.7, 70),
      ),
      child: Coustom.text(
        text: "LOGIN",
        textAlign: TextAlign.center,
        fontSize: 20,
        colors: AppColors.darkBlue,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  TextButton forgotPasswordButton(double mediaWidth) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        // backgroundColor: AppColors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
        minimumSize: Size(mediaWidth / 9, 0),
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Coustom.text(
        text: "Forgot Password?",
        textAlign: TextAlign.center,
        fontSize: 16,
        colors: AppColors.green,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget newAccountSignup() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "Don't have an account? ",
          style: Coustom.style(
            colors: AppColors.white.withOpacity(0.64),
          ),
          children: [
            WidgetSpan(
              child: Coustom.text(
                text: "Sign up",
                colors: AppColors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
}
