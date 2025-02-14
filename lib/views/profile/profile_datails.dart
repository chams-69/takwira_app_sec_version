import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takwira_app/data/user_data.dart';

class Foot extends StateNotifier<bool> {
  Foot() : super(false);
  void otherFoot() {
    state = !state;
  }
}

final footProvider = StateNotifierProvider<Foot, bool>(((ref) {
  return Foot();
}));

class ProfileDetails extends ConsumerWidget {
  final dynamic? currentUser;
  const ProfileDetails({super.key, this.currentUser});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileData = ref.watch(userDataProvider);
    final foot = ref.watch(footProvider);

    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(62)),
        child: Column(
          children: [
            SizedBox(height: width(30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Age',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(16),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: width(90),
                  child: Text(
                    '${currentUser['age']} Years',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: width(38)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Height',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(16),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: width(90),
                  child: Text(
                    '${profileData.height} cm',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: width(38)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weight',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(16),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: width(90),
                  child: Text(
                    '${profileData.weight} Kg',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: width(38)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Foot',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(16),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      ref.read(footProvider.notifier).otherFoot();
                    },
                    child: foot == true
                        ? Row(
                            children: [
                              Transform.rotate(
                                angle: 30 * (3.141592653589793 / 180),
                                child: Image.asset(
                                  'assets/images/right.png',
                                  width: width(30),
                                  height: width(30),
                                ),
                              ),
                              SizedBox(width: width(10)),
                              Text(
                                'Right',
                                style: TextStyle(
                                  color: const Color(0xFFF1EED0),
                                  fontSize: width(16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                'Left',
                                style: TextStyle(
                                  color: const Color(0xFFF1EED0),
                                  fontSize: width(16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: width(10)),
                              Transform.rotate(
                                angle: -30 * (3.141592653589793 / 180),
                                child: Image.asset(
                                  'assets/images/left.png',
                                  width: width(30),
                                  height: width(30),
                                ),
                              ),
                            ],
                          )),
              ],
            ),
            SizedBox(height: width(38)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jersey Number',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(16),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          'assets/images/jerseyNumber.png',
                          width: width(50),
                          height: width(50),
                        ),
                        Positioned(
                          top: width(13),
                          child: SizedBox(
                            width: width(50),
                            child: Text(
                              '${profileData.jerseyNumber}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFFF1EED0),
                                fontSize: width(16),
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width(15)),
                  ],
                ),
              ],
            ),
            SizedBox(height: width(38)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Position',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(16),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  width: width(90),
                  child: Text(
                    profileData.post,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: width(38)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Other Positions',
                  style: TextStyle(
                    color: const Color(0xFFF1EED0),
                    fontSize: width(16),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                if (profileData.otherPosts.isNotEmpty)
                  SizedBox(
                    width: profileData.otherPosts.length == 1
                        ? width(65)
                        : profileData.otherPosts.length == 2
                            ? width(80)
                            : width(109),
                    child: Row(
                      children: List.generate(
                        profileData.otherPosts.length,
                        (index) => Row(
                          children: [
                            Text(
                              profileData.otherPosts[index],
                              style: TextStyle(
                                color: const Color(0xFFF1EED0),
                                fontSize: width(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (index < (profileData.otherPosts.length - 1))
                              SizedBox(width: width(10)),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
