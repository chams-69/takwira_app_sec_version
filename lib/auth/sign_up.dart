import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:takwira_app/auth/log_in.dart';
import 'package:takwira_app/views/navigation/navigation.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    void signUp(BuildContext context) async {
      var url = Uri.parse('https://takwira.me/register');
      var response = await http.post(
        url,
        headers: {
          'flutter': 'true',
        },
        body: {
          'fName': firstNameController.text,
          'lName': lastNameController.text,
          'username': usernameController.text,
          'phone': phoneNumberController.text,
          'emailSignUp': emailController.text,
          'passSignUp': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);

        var bodyError = responseBody['error'];
        var bodySuccess = responseBody['success'];
        print(bodySuccess);
        if (bodyError != "" && bodyError !=null) {
          setState(() {
            errorMessage = bodyError;
          });
          print(errorMessage);
        } else if(bodySuccess){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LogIn(),
            ),
          );
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    }

    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    double screenHeight = MediaQuery.of(context).size.height;
    double height(double height) {
      a = height / 932;
      return screenHeight * a;
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/4aw.png',
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: height(350)),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color.fromRGBO(0, 0, 0, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Image.asset(
            'assets/images/smoke.png',
            fit: BoxFit.cover,
            opacity: const AlwaysStoppedAnimation(0.15),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(width(20), 0, width(20), width(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height(90)),
                    child: Text(
                      'Let\'s get Started',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: firstNameController,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBEBCA5),
                        fontSize: width(16),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: lastNameController,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBEBCA5),
                        fontSize: width(16),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: usernameController,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBEBCA5),
                        fontSize: width(16),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneNumberController,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBEBCA5),
                        fontSize: width(16),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBEBCA5),
                        fontSize: width(16),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBEBCA5),
                        fontSize: width(16),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      hintStyle: TextStyle(
                        color: const Color(0xFFBEBCA5),
                        fontSize: width(16),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFFF1EED0),
                      backgroundColor:
                          const Color(0xFF599068), // button's shape
                    ),
                    onPressed: () {
                      signUp(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(width(13)),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    errorMessage, // Display the error message
                    style: TextStyle(
                      color: Colors.red, // Set text color to red
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You already have an account?',
                        style: TextStyle(
                          color: const Color(0xFFF1EED0),
                          fontSize: width(16),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LogIn(),
                            ),
                          );
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            color: const Color(0xff599068),
                            fontSize: width(16),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Image.asset('assets/images/google.png'),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Sign Up with Google',
                                  style: TextStyle(
                                    color: const Color(0xFFF1EED0),
                                    fontSize: width(16),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Image.asset('assets/images/facebook.png'),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Sign Up with Facebook',
                                  style: TextStyle(
                                    color: const Color(0xFFF1EED0),
                                    fontSize: width(16),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
