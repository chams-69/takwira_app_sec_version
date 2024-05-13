import 'package:flutter/material.dart';
import 'package:takwira_app/views/cards/field_card.dart';
import 'package:takwira_app/views/fieldProfile/field_profile.dart';

class AllMyFields extends StatelessWidget {
  const AllMyFields({super.key});

  @override
  Widget build(BuildContext context) {
    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    return Scaffold(
      backgroundColor: const Color(0xff343835),
      appBar: AppBar(
        backgroundColor: const Color(0xff343835),
        iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'My Fields',
            style: TextStyle(
              color: Color(0xFFF1EED0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width(60)),
          child: Column(
            children: [
              SizedBox(height: width(15)),
              Column(
                children: List.generate(
                  10,
                  (index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FieldProfile(field : null),
                              ),
                            );
                          },
                          child: Ink(child: FieldCard(field : null)),
                        ),
                        SizedBox(height: width(15)),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
