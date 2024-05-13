import 'package:flutter/material.dart';
import 'package:takwira_app/views/cards/field_card.dart';
import 'package:takwira_app/views/fieldProfile/field_profile.dart';
import 'package:takwira_app/views/myActivities/myFields/all_my_fields.dart';
import 'package:takwira_app/views/navigation/fields.dart';

class MyFields extends StatelessWidget {
  const MyFields({super.key});

  @override
  Widget build(BuildContext context) {
    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Column(
            children: List.generate(
              3,
              (index) {
                return Column(
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FieldProfile(field : null),
                            ),
                          );
                        },
                        child: Ink(
                            child: Stack(
                          children: [
                            FieldCard(field : null),
                          ],
                        )),
                      ),
                    ),
                    SizedBox(height: width(20)),
                  ],
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AllMyFields(),
                ),
              );
            },
            child: Text(
              'See more',
              style: TextStyle(
                  color: const Color(0xFFF1EED0),
                  fontSize: width(12),
                  fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'See other fields',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(12),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Fields(),
                        ),
                      );
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: const Color(0xFFF1EED0),
                          fontSize: width(10),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
          SizedBox(height: width(10)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Row(
                  children: List.generate(
                    5,
                    (index) {
                      return Row(
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
                          SizedBox(width: width(11)),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: width(25)),
        ],
      ),
    );
  }
}
