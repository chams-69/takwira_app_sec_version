import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takwira_app/data/field_data.dart';
import 'package:takwira_app/providers/switch.dart';
import 'package:takwira_app/views/create/age_group.dart';
import 'package:takwira_app/views/create/number_selector.dart';
import 'package:takwira_app/views/create/position_selector.dart';
import 'package:http/http.dart' as http;

final switchProvider = StateNotifierProvider<Switched, bool>((ref) {
  return Switched();
});

class CreateGame extends ConsumerStatefulWidget {
  const CreateGame({super.key});

  @override
  ConsumerState<CreateGame> createState() => _CreateGameState();
}

class _CreateGameState extends ConsumerState<CreateGame> {
  

  @override
  void initState() {
    super.initState();
    fetchGameData();
  }
  int selectedIndex = 0;
  int _selectedNumber = 14;
  List<String> selectedPositions = [];
  List<String> availablePositions = [
    'GK',
    'CB',
    'RB',
    'LB',
    'CDM',
    'CM',
    'CAM',
    'RW',
    'LW',
    'ST'
  ];

  dynamic? teams , followers , following , userid , fields;

  void fetchGameData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username') ?? '';
    var id = prefs.getString('id') ?? '';
    var token = prefs.getString('token') ?? '';
    if (username.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse('https://takwira.me/api/game/creation/data?username=$username'),
          headers: {
            'flutter': 'true',
            'authorization' : token,
          },
        );
        if (response.statusCode == 200) {
          final gameResponse = jsonDecode(response.body);
          print(gameResponse);
          setState(() {
            teams = gameResponse['teams'];
            followers = gameResponse['followers'];
            following = gameResponse['following'];
            fields = gameResponse['fields'];
            userid = id;
          });
        } else {
          print('Failed to fetch user data: ${response.statusCode}');
        }
      } catch (e) {
        print('Failed to fetch user data: $e');
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final private = ref.watch(switchProvider);
    // final fieldData = ref.watch(fieldDataProvider);

    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    String date = 'dd mon yyyy, Today';
    String time = '9:00 pm';
    double price = 90;

    Widget selectedTab(String selected, {required bool isSelected}) {
      return Text(
        selected,
        style: TextStyle(
          color: isSelected ? const Color(0xFFF1EED0) : const Color(0xFFBFBCA0),
          fontSize: width(12),
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xff343835),
        appBar: AppBar(
          backgroundColor: const Color(0xff343835),
          iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
          title: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Create Game',
              style: TextStyle(
                color: Color(0xFFF1EED0),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          centerTitle: true,
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      color: Color(0xFF599068),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(width: width(13)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(41)),
                child: InkWell(
                  onTap: () {},
                  child: Ink(
                    child: Stack(
                      children: [
                        Container(
                          width: width(348),
                          height: width(174),
                          color: const Color(
                              0xff474D48), // Set your desired color here
                          child: Image.asset(
                            'assets/images/gameBg.png',
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(0.2),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: width(45)),
                            Center(
                              child: IconButton(
                                onPressed: () {},
                                icon: Image.asset(
                                  'assets/images/photo.png',
                                  width: width(45),
                                  height: width(45),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Upload Cover Photo',
                                style: TextStyle(
                                  color: const Color(0xFFBFBCA0),
                                  fontSize: width(12),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: width(21)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(21)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Private Game',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: width(20)),
                        Transform.scale(
                            scale: width(0.7),
                            child: Switch(
                              onChanged: (value) {
                                ref
                                    .read(switchProvider.notifier)
                                    .toggleSwitch(private);
                              },
                              value: private,
                              activeColor: Color(0xFF599068),
                              inactiveThumbColor: Color(0xFF599068),
                              inactiveTrackColor: Color(0xff6C736D),
                            )),
                      ],
                    ),
                    SizedBox(height: width(28)),
                    Text(
                      'Game Title',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: width(50)),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Color(0xFFF1EED0)),
                            decoration: InputDecoration(
                              hintText: 'Enter your Team name',
                              hintStyle: TextStyle(
                                color: const Color(0xFFA09F8D),
                                fontSize: width(14),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width(25)),
                    Text(
                      'Description',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: width(50)),
                        Expanded(
                          child: TextField(
                            
                            style: const TextStyle(color: Color(0xFFF1EED0)),
                            decoration: InputDecoration(
                              hintText: 'Enter your Team descreption',
                              hintStyle: TextStyle(
                                color: const Color(0xFFA09F8D),
                                fontSize: width(14),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: width(66)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'add Location',
                                style: TextStyle(
                                  color: Color(0xFF599068),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width(20),
                              height: width(20),
                              child: SpeedDial(
                                backgroundColor: Colors.transparent,
                                overlayColor: Colors.black,
                                overlayOpacity: 0.4,
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                children: [
                                  SpeedDialChild(
                                    labelWidget: Container(
                                      padding: const EdgeInsets.all(7.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF1EED0)
                                            .withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(width(20)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width(14)),
                                        child: Text(
                                          'outside Koora fields',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width(15),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                  SpeedDialChild(
                                    labelWidget: Container(
                                      padding: const EdgeInsets.all(7.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF1EED0)
                                            .withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(width(20)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width(14)),
                                        child: Text(
                                          'My existing Booking',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width(15),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                  SpeedDialChild(
                                    labelWidget: Container(
                                      padding: const EdgeInsets.all(7.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF1EED0)
                                            .withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(width(20)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width(14)),
                                        child: Text(
                                          'new Booking',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: width(15),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                                child: Image.asset(
                                  'assets/images/adress2.png',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: width(48)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                color: const Color(0xFFF1EED0),
                                fontSize: width(12),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: width(8)),
                            Image.asset(
                              'assets/images/date.png',
                              width: width(16),
                              height: width(16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: width(18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              time,
                              style: TextStyle(
                                color: const Color(0xFFF1EED0),
                                fontSize: width(12),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: width(8)),
                            Image.asset(
                              'assets/images/open.png',
                              width: width(16),
                              height: width(16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: width(18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '$price',
                              style: TextStyle(
                                color: const Color(0xFFF1EED0),
                                fontSize: width(12),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            SizedBox(width: width(8)),
                            Text(
                              'DNT',
                              style: TextStyle(
                                color: const Color(0xFF599068),
                                fontSize: width(12),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: width(48)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No. of players needed',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        NumberSelector(
                            selectedNumber: _selectedNumber,
                            itemCount: 15,
                            onNumberSelected: (number) {
                              setState(() {
                                _selectedNumber = number;
                              });
                            }),
                      ],
                    ),
                    SizedBox(height: width(15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Positions needed',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        PositionSelector(
                          selectedPositions: selectedPositions,
                          availablePositions: availablePositions,
                          onPositionsSelected: (positions) {
                            setState(() {
                              selectedPositions = positions;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: width(59)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Age group',
                          style: TextStyle(
                            color: const Color(0xFFF1EED0),
                            fontSize: width(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: width(20)),
                        const Expanded(
                          child: AgeGroup(),
                        ),
                        SizedBox(width: width(10)),
                      ],
                    ),
                    SizedBox(height: width(94)),
                    SizedBox(
                      width: screenWidth,
                      child: Text(
                        'import Teams',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFBFBCA0),
                          fontSize: width(14),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: width(17)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/importTeam.png',
                                    width: width(16),
                                    height: width(16),
                                  ),
                                  SizedBox(width: width(5)),
                                  Text(
                                    'import Teams',
                                    style: TextStyle(
                                      color: const Color(0xFF599068),
                                      fontSize: width(12),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/images/search.png',
                            width: width(14),
                            height: width(14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: width(8)),
              SizedBox(
                height: width(41),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xFF415346),
                        Color(0xff343835),
                      ],
                    ),
                  ),
                  child: TabBar(
                    dividerColor: const Color(0xFF4E6955),
                    indicatorColor: const Color(0xFFF1EED0),
                    // indicatorSize: TabBarIndicatorSize.tab,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    tabs: [
                      Tab(
                        icon: selectedTab(
                          'Followers',
                          isSelected: selectedIndex == 0,
                        ),
                      ),
                      Tab(
                        icon: selectedTab(
                          'Following',
                          isSelected: selectedIndex == 1,
                        ),
                      ),
                      Tab(
                        icon: selectedTab(
                          'Groups',
                          isSelected: selectedIndex == 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IndexedStack(
                index: selectedIndex,
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
