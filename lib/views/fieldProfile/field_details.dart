import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takwira_app/data/field_data.dart';

class FieldDetails extends ConsumerWidget {
  final dynamic? field;
  const FieldDetails({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldData = ref.watch(fieldDataProvider);

    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: width(30)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width(61)),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/adress2.png',
                      width: width(16),
                      height: width(16),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        fieldData.adress,
                        style: TextStyle(
                          color: const Color(0xFF5C7E6C),
                          fontSize: width(12),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: width(12)),
                // Row(
                //   children: [
                //     Image.asset(
                //       'assets/images/phone.png',
                //       width: width(16),
                //       height: width(16),
                //     ),
                //     TextButton(
                //       onPressed: () {},
                //       child: Text(
                //         fieldData.phone,
                //         style: TextStyle(
                //           color: const Color(0xFF5C7E6C),
                //           fontSize: width(12),
                //           fontWeight: FontWeight.w700,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: width(12)),
                // Row(
                //   children: [
                //     Image.asset(
                //       'assets/images/mail.png',
                //       width: width(16),
                //       height: width(16),
                //     ),
                //     TextButton(
                //       onPressed: () {},
                //       child: Text(
                //         fieldData.mail,
                //         style: TextStyle(
                //           color: const Color(0xFF5C7E6C),
                //           fontSize: width(12),
                //           fontWeight: FontWeight.w700,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(height: width(32)),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/open.png',
                      width: width(16),
                      height: width(16),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Open now',
                            style: TextStyle(
                              color: const Color(0xFF599068),
                              fontSize: width(12),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: width(3)),
                          Column(
                            children: [
                              SizedBox(height: width(5)),
                              Image.asset(
                                'assets/images/clockUp.png',
                                width: width(9),
                                height: width(9),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width(32)),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/field.png',
                      width: width(16),
                      height: width(16),
                    ),
                    SizedBox(width: width(5)),
                    Text(
                      '${field['nbFields']} fields',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(12),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width(5)),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/price.png',
                      width: width(16),
                      height: width(16),
                    ),
                    SizedBox(width: width(5)),
                    Text(
                      '${field['price']} DNT',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(12),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width(100)),
            child: Column(
              children: [
                SizedBox(height: width(35)),
                Text(
                  /* LAHNA YY CHAMS A3MEL EL BOUCLE AAL SERVICES*/ 
                  'Our Services',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(12),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: width(24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/park.png',
                          width: width(14),
                          height: width(14),
                        ),
                        SizedBox(width: width(5)),
                        Text(
                          'Parking',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(12),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/wc2.png',
                          width: width(16),
                          height: width(16),
                        ),
                        SizedBox(width: width(5)),
                        Text(
                          'Toilets',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(12),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: width(5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/coffe2.png',
                          width: width(14),
                          height: width(14),
                        ),
                        SizedBox(width: width(5)),
                        Text(
                          'Cafeteria',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(12),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/water2.png',
                          width: width(16),
                          height: width(16),
                        ),
                        SizedBox(width: width(5)),
                        Text(
                          'Water',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(12),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width(42)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: width(43)),
                Text(
                  'about ${field['name']}',
                  style: TextStyle(
                    color: const Color(0xFFBFBCA0),
                    fontSize: width(12),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: width(9)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(18)),
                  child: Text(
                    field['description'],
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(10),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: width(38)),
        ],
      ),
    );
  }
}
