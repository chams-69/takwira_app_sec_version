import 'package:flutter/material.dart';
import 'package:takwira_app/auth/forgotPassword/email_verif_pass.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: height(10)),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xffF1EED0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: height(70)),
                  Padding(
                    padding: EdgeInsets.only(left: width(35)),
                    child: Image.asset('assets/images/forgotPassword.png'),
                  ),
                  SizedBox(height: height(30)),
                  Text(
                    'Forgot your Password?',
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(28),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height(15)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'We\'ll be sending you an email to confirm that you\'re the rightful user. This helps us ensure the security of your account and provide you with the best experience possible. \nThank you for your cooperation in this matter.',
                      style: TextStyle(color: Color(0xffF1EED0)),
                    ),
                  ),
                  SizedBox(height: height(70)),
                  Row(
                    children: [
                      Text(
                        'your Email',
                        style: TextStyle(
                          color: const Color(0xFFBEBCA5),
                          fontSize: width(16),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height(20)),
                  Container(
                    height: width(60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width(20)),
                      border: Border.all(color: Color(0xFFF1EED0)),
                    ),
                    child: Container(
                      width: 2000,
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            width(20), width(14), 0, width(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'example@gmail.com',
                              style: TextStyle(
                                  color: Color(0xFFF1EED0),
                                  fontSize: width(18),
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EmailVerifPass(),
                                  ),
                                );
                              },
                              child: Image.asset(
                                'assets/images/send.png',
                                width: width(80),
                                height: width(80),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
