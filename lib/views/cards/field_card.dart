import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takwira_app/data/field_data.dart';
import 'package:takwira_app/providers/loved.dart';
import 'package:takwira_app/views/fieldProfile/field_profile.dart';

final loveProvider = StateNotifierProvider<Loved, bool>(((ref) {
  return Loved();
}));

class FieldCard extends ConsumerWidget {
  final dynamic? field;
  const FieldCard({super.key, required this.field});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldData = ref.watch(fieldDataProvider);
    final loved = ref.watch(loveProvider);
    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: width(2)),
          child: SizedBox(
            width: width(306.59),
            height: width(177),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                field['field']['image'],
                fit: BoxFit.cover,
                opacity: const AlwaysStoppedAnimation(0.6),
              ),
            ),
          ),
        ),
        Positioned(
          top: width(15),
          child: Container(
            width: width(70),
            height: width(17),
            decoration: BoxDecoration(
              color: const Color(0xFF599068).withOpacity(0.6),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(width(3)),
                bottomRight: Radius.circular(width(3)),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(width(7), width(1), 0, 0),
              child: Text(
                '${field['field']['price']} DNT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFF1EED0),
                  fontSize: width(10),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: width(36),
          left: width(123),
          child: Text(
            field['field']['name'],
            style: TextStyle(
              color: const Color(0xFFF1EED0),
              fontSize: width(12),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        SizedBox(
          width: width(308.59),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width(22)),
            child: Column(
              children: [
                SizedBox(height: width(65)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/parking.png',
                          width: width(10),
                          height: width(10),
                        ),
                        SizedBox(width: width(5)),
                        Text(
                          'Parking',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(10),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/adress.png',
                          width: width(12),
                          height: width(12),
                        ),
                        SizedBox(width: width(2)),
                        Text(
                          fieldData.adress,
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(10),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: width(2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/coffe.png',
                          width: width(10),
                          height: width(10),
                        ),
                        SizedBox(width: width(5)),
                        Text(
                          'Cafeteria',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(10),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${(field['field']['distance'] as double).toStringAsFixed(2)} Km away',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(10),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width(2)),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/wc.png',
                      width: width(10),
                      height: width(10),
                    ),
                    SizedBox(width: width(5)),
                    Text(
                      'Toilets',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(10),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: width(2)),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/water.png',
                      width: width(10),
                      height: width(10),
                    ),
                    SizedBox(width: width(5)),
                    Text(
                      'Water',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(10),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: width(123),
          left: width(235),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFF1EED0),
              backgroundColor: const Color(0xFF599068),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width(5)),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: width(15), vertical: width(10)), // button's shape
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FieldProfile(field : null),
                ),
              );
            },
            child: Text(
              'Book',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: width(10),
              ),
            ),
          ),
        ),
        Positioned(
          top: width(17),
          right: width(29),
          child: InkWell(
            onTap: () {
              ref.read(loveProvider.notifier).lovePressed();
            },
            child: Ink(
              child: Image.asset(
                loved == false
                    ? 'assets/images/love.png'
                    : 'assets/images/loved.png',
                width: width(19),
                height: width(19),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
