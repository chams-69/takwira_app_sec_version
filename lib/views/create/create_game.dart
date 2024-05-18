import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takwira_app/providers/switch.dart';
import 'package:takwira_app/views/create/age_group.dart';
import 'package:takwira_app/views/create/number_selector.dart';
import 'package:takwira_app/views/create/position_selector.dart';
import 'package:http/http.dart' as http;
import 'package:takwira_app/views/cards/field_card.dart';
import 'package:takwira_app/views/games/game_details.dart';

final switchProvider = StateNotifierProvider<Switched, bool>((ref) {
  return Switched();
});

class CreateGame extends ConsumerStatefulWidget {
  const CreateGame({super.key});

  @override
  ConsumerState<CreateGame> createState() => _CreateGameState();
}

class _CreateGameState extends ConsumerState<CreateGame> {
  int selectedField = -1;



  List<dynamic> found = [];

  @override
  void initState() {
    fetchGameData();
    super.initState();
  }

  void filter(String onSearch) {
    List<dynamic> results = [];
    if (onSearch.isEmpty) {
      results = players;
    } else {
      results = players
          .where((element) =>
              element["fName"]
                  .toString()
                  .toLowerCase()
                  .contains(onSearch.toLowerCase()) ||
              element["username"]
                  .toString()
                  .toLowerCase()
                  .contains(onSearch.toLowerCase()))
          .toList();
    }
    setState(() {
      found = results;
    });
  }

  List<Map<String, dynamic>> selectedPlayers = [];

  void togglePlayerSelection(int index) {
    setState(() {
      if (selectedPlayers.contains(found[index])) {
        selectedPlayers.remove(found[index]);
      } else {
        selectedPlayers.add(found[index]);
      }
    });
  }

  int selectedIndex = 0;
  String? imagePath;
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

  DateTime date = DateTime.now();

  void showDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    ).then((value) {
      setState(() {
        date = value!;
      });
    });
  }

  String? errorMessage;
  
  void createGame() async{
    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username') ?? '';
    var token = prefs.getString('token') ?? '';
    final Uri url = Uri.parse('https://takwira.me/api/creategame');

    final http.Response response = await http.post(
      url,
      headers: {
        'flutter': 'true',
        'authorization' : token,
      },
      body: {
        'joinedPlayers': jsonEncode(selectedPlayers),
        'field': jsonEncode(fields[selectedField]),
        'username': username,
        'token': token
      },
    );
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      var bodySuccess = responseBody['success'];
      if (bodySuccess) {
        var game = responseBody['game'];
        setState((){
          errorMessage = "";
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameDetails(gameDataS: game),
          ),
        );
      } else {
        setState((){
          errorMessage = "Your should pick a field and correct date";
        });
      }
    }
  }

  dynamic? teams, players, userid, fields;

  void fetchGameData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username') ?? '';
    var id = prefs.getString('id') ?? '';
    var token = prefs.getString('token') ?? '';
    if (username.isNotEmpty) {
      try {
        final response = await http.get(
          Uri.parse(
              'https://takwira.me/api/game/creation/data?username=$username'),
          headers: {
            'flutter': 'true',
            'authorization': token,
          },
        );
        if (response.statusCode == 200) {
          final gameResponse = jsonDecode(response.body);
          setState(() {
            teams = gameResponse['teams'];
            players = gameResponse['players'];
            fields = gameResponse['fields'];
            userid = id;
            setState(() {
              found = players;
            });
          });
        } else {
          print('Failed to fetch user data: ${response.statusCode}');
        }
      } catch (e) {
        print('Failed to fetch user data wawa: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final private = ref.watch(switchProvider);

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
                  onPressed: () {
                    createGame();
                  },
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
              SizedBox(height: width(21)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(21)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: width(50)),
                    Text(
                      'Location',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: width(10)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          fields.length,
                          (index) {
                            final field = fields[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedField =
                                      selectedField == index ? -1 : index;
                                });
                              },
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      FieldCard(field : field),
                                      if (selectedField == index)
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: width(2)),
                                          child: Container(
                                            width: width(306.59),
                                            height: width(177),
                                            decoration: BoxDecoration(
                                              color: Color(0xff599068)
                                                  .withOpacity(0.25),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width(15)),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(width: width(11)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: width(30)),
                    Padding(
                      padding: EdgeInsets.only(right: width(10)),
                      child: Row(
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
                                date.toString().split(" ")[0],
                                style: TextStyle(
                                  color: const Color(0xFFF1EED0),
                                  fontSize: width(12),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(width: width(8)),
                              IconButton(
                                onPressed: showDate,
                                icon: Image.asset(
                                  'assets/images/date.png',
                                  width: width(16),
                                  height: width(16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: width(30)),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       'No. of players needed',
                    //       style: TextStyle(
                    //         color: const Color(0xFFF1EED0),
                    //         fontSize: width(14),
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //     ),
                    //     NumberSelector(
                    //         selectedNumber: _selectedNumber,
                    //         itemCount: 15,
                    //         onNumberSelected: (number) {
                    //           setState(() {
                    //             _selectedNumber = number;
                    //           });
                    //         }),
                    //   ],
                    // ),
                    // SizedBox(height: width(15)),
                    Padding(
                      padding: EdgeInsets.only(right: width(10)),
                      child: Row(
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
                    ),
                    SizedBox(height: width(40)),
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
                    SizedBox(height: width(50)),
                    SizedBox(
                      width: screenWidth,
                      child: Text(
                        'invite Players',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFBFBCA0),
                          fontSize: width(14),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(right: width(21)),
                      child: Container(
                        color: Colors.transparent,
                        height: width(35),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(width(9)),
                          child: Container(
                            width: 2000,
                            color: Color(0xff474D48),
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset('assets/images/searchIcon.png'),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 0, width(10), width(5)),
                                    child: TextField(
                                      onChanged: (value) => filter(value),
                                      style: const TextStyle(
                                        color: Color(0xFFF1EED0),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Search...',
                                        hintStyle: TextStyle(
                                          color: const Color(0xFFA09F8D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w100,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: EdgeInsets.only(right: width(21)),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.80,
                        child: ListView.builder(
                          itemCount: found.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => togglePlayerSelection(index),
                            child: Column(
                              children: [
                                Stack(children: [
                                  ListTile(
                                    leading: Stack(
                                      children: [
                                        Image.asset(
                                          'assets/images/profileIcon.png',
                                          width: 50,
                                        ),
                                        SizedBox(
                                          width: 50,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 9, 8, 9),
                                            child: Image.asset(
                                              'assets/images/avatar.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    title: Text(
                                      found[index]['username'],
                                      style: TextStyle(
                                        color: const Color(0xFFF1EED0),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(found[index]['fName']),
                                    subtitleTextStyle: TextStyle(
                                      color: const Color(0xFFA09F8D),
                                    ),
                                  ),
                                  if (selectedPlayers.contains(found[index]))
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff599068)
                                              .withOpacity(0.25),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                ]),
                                SizedBox(height: 3),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
