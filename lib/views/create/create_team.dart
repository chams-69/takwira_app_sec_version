import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takwira_app/providers/switch.dart';
import 'package:takwira_app/views/create/age_group.dart';
import 'package:takwira_app/views/create/number_selector.dart';
import 'package:takwira_app/views/create/position_selector.dart';
import 'package:takwira_app/views/teams/team_details.dart';

final switchProvider = StateNotifierProvider<Switched, bool>((ref) {
  return Switched();
});

class CreateTeam extends ConsumerStatefulWidget {
  const CreateTeam({super.key});
  

  @override
  ConsumerState<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends ConsumerState<CreateTeam> {
  String errorMessage = '';
  final TextEditingController teamNameController = TextEditingController();
  final TextEditingController teamDescriptionController =TextEditingController();
  int selectedIndex = 0;
  int _selectedNumber = 6;
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

  Future<void> createTeam(BuildContext context) async {
    final String teamName = teamNameController.text;
    final String teamDescription = teamDescriptionController.text;


    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username') ?? '';
    var token = prefs.getString('token') ?? '';
    final Uri url = Uri.parse('https://takwira.me/api/createteam');
    final http.Response response = await http.post(
      url,
      headers: {
        'flutter': 'true',
        'authorization' : token,
      },
      body: {
        'teamName': teamName,
        'teamDescription': teamDescription,
        'username': username,
        'token': token
      },
    );

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);

      var bodySuccess = responseBody['success'];
      print(bodySuccess);
      if (bodySuccess) {
        var team = responseBody['team'];
        print(team);
        setState((){
          errorMessage = "";
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TeamDetails(team: team),
          ),
        );
      } else {
        setState((){
          errorMessage = "Field Name should be unique and description should not be empty";
        });
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
              'Create your Team',
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
                  onPressed: () {createTeam(context);},
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
                            'assets/images/teamBg.png',
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
                          'Private Team',
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
                      'Team name',
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: width(10)),
                    Row(
                      children: [
                        SizedBox(width: width(50)),
                        Expanded(
                          child: TextField(
                            controller: teamNameController,
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
                    SizedBox(height: width(10)),
                    Row(
                      children: [
                        SizedBox(width: width(50)),
                        Expanded(
                          child: TextField(
                            controller: teamDescriptionController,
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
                    Visibility(
                      visible: errorMessage.isNotEmpty,
                      child: Padding(
                        padding: EdgeInsets.only(left: width(40), top: width(30)), // Added margin-top
                        child: Text(
                          errorMessage,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: width(14),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: width(65)),
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
                        // Replace IconButton with NumberSelector
                        NumberSelector(
                            selectedNumber: _selectedNumber,
                            itemCount: 7,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'invite Players from',
                          style: TextStyle(
                            color: const Color(0xFFBFBCA0),
                            fontSize: width(14),
                            fontWeight: FontWeight.normal,
                          ),
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
                    indicatorSize: TabBarIndicatorSize.tab,
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
