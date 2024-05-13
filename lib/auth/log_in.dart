import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takwira_app/auth/sign_up.dart';
import 'package:takwira_app/views/navigation/navigation.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key});

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> signIn(BuildContext context) async {
    final String email = usernameController.text;
    final String password = passwordController.text;

    final Uri url = Uri.parse('https://takwira.me/login');
    final http.Response response = await http.post(
      url,
      headers: {
          'flutter': 'true',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      var bodyError = responseBody['error'];
      var bodySuccess = responseBody['success'];
      if (bodyError != "" && bodyError !=null) {
          setState(() {
            errorMessage = bodyError;
          });
          print(errorMessage);
      } else if(bodySuccess) {
        var user = responseBody['user'];
        var token = responseBody['token'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', user['username']);
        await prefs.setString('id', user['_id']);
        await prefs.setString('token', token);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Navigation(index: 2),
          ),
        );
      }
    } else {
      setState(() {
        errorMessage = 'Invalid username or password.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/4aw.png',
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: 350),
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
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 230),
                    child: Text(
                      'Welcome Back',
                      style: const TextStyle(
                        color: Color(0xFFF1EED0),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 80),
                  TextField(
                    controller: usernameController,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: const InputDecoration(
                      hintText: 'User name Or Email Or Phone Number',
                      hintStyle: TextStyle(
                        color: Color(0xFFBEBCA5),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Color(0xFFF1EED0)),
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Color(0xFFBEBCA5),
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Color(0xFFF1EED0),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFFF1EED0),
                      backgroundColor: Color(0xFF599068),
                    ),
                    onPressed: () {
                      signIn(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Color(0xFFF1EED0),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ),
                          );
                        },
                        child: const Text(
                          'Register here',
                          style: TextStyle(
                            color: Color(0xFF599068),
                            fontSize: 16,
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
                                child: const Text(
                                  'Sign In with Google',
                                  style: TextStyle(
                                    color: Color(0xFFF1EED0),
                                    fontSize: 16,
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
                                child: const Text(
                                  'Sign In with Facebook',
                                  style: TextStyle(
                                    color: Color(0xFFF1EED0),
                                    fontSize: 16,
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
