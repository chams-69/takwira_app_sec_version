import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:takwira_app/data/team.data.dart';
import 'package:takwira_app/data/user_data.dart';
import 'package:takwira_app/providers/sent.dart';
import 'package:takwira_app/views/cards/profile_card.dart';
import 'package:takwira_app/views/playerProfile/player_profile.dart';

final sentProvider = StateNotifierProvider<Sent, bool>(((ref) {
  return Sent();
}));

class TeamDetails extends ConsumerWidget {
  final dynamic? team;
  const TeamDetails({super.key, required this.team});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamData = ref.watch(teamDataProvider);
    final playerData = ref.watch(userDataProvider);
    final sent = ref.watch(sentProvider);
    bool member = false;
    bool owner = false;


    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    Map<String, String> positionsMap = {
      'GK': 'Goalkeeper',
      'CB': 'Center Back',
      'RB': 'Right Back',
      'LB': 'Left Back',
      'CDM': 'Defensive Midfielder',
      'CM': 'Central Midfielder',
      'CAM': 'Attacking Midfielder',
      'RW': 'Right Winger',
      'LW': 'Left Winger',
      'ST': 'Striker',
    };

    return Scaffold(
      backgroundColor: const Color(0xff343835),
      appBar: AppBar(
        backgroundColor: const Color(0xff343835),
        iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Team details',
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
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/images/share.png'),
              ),
              const SizedBox(width: 5),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width(15)),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(21)),
                  child: SizedBox(
                    width: width(388),
                    height: width(228),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/teamBg.png',
                        fit: BoxFit.cover,
                        opacity: const AlwaysStoppedAnimation(0.6),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/linear3.png',
                  width: screenWidth,
                  height: width(253),
                ),
                Column(
                  children: [
                    SizedBox(height: width(52)),
                    Center(
                      child: Text(
                        team['team']['teamName'],
                        style: TextStyle(
                          color: const Color(0xFFF1EED0),
                          fontSize: width(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: width(12)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width(88)),
                      child: Text(
                        "We're looking for ${7 - team['team']['teamLength']} more players to join our team",
                        style: TextStyle(
                          color: const Color(0xffF1EED0),
                          fontWeight: FontWeight.normal,
                          fontSize: width(16),
                        ),
                      ),
                    ),
                    SizedBox(height: width(30)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width(41)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/profileIcon.png',
                                    width: width(34),
                                    height: width(40),
                                  ),
                                  SizedBox(
                                    width: width(34),
                                    height: width(40),
                                    child: Padding(
                                      padding: EdgeInsets.all(width(7)),
                                      child: Image.network(
                                        team['team']['teamOwner']['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: width(5)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Text(
                                        'Leader',
                                        style: TextStyle(
                                          color: const Color(0xFF599068),
                                          fontSize: width(9),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: width(1)),
                                        child: Text(
                                          'Leader',
                                          style: TextStyle(
                                            color: const Color(0xFF599068),
                                            fontSize: width(9),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                width(1.14), width(0.5), 0, 0),
                                            child: Text(
                                              'Leader',
                                              style: TextStyle(
                                                color: const Color(0xFFF1EED0),
                                                fontSize: width(9),
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: width(5)),
                                          Image.network(
                                            'assets/images/leader.png',
                                            width: width(14),
                                            height: width(14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    team['team']['teamOwner']['username'],
                                    style: TextStyle(
                                      color: const Color(0xFFF1EED0),
                                      fontSize: width(10),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          if (owner == false)
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/msg.png',
                                    width: width(23),
                                    height: width(24),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/call.png',
                                    width: width(24),
                                    height: width(24),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: teamData.positionsNeeded.isEmpty
                      ? width(160)
                      : width(160 + teamData.positionsNeeded.length * 34),
                  // height: width(279),
                  child: Image.asset(
                    'assets/images/linear4.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: width(27),
                  right: width(41),
                  child: Image.asset(
                    'assets/images/jerseyNum.png',
                    width: width(24),
                    height: width(24),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: width(40)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width(41), 0, width(82), 0),
                      child: LinearProgressBar(
                        maxSteps: teamData.playersNeeded,
                        progressType: LinearProgressBar
                            .progressTypeLinear, // Use Linear progress
                        currentStep: team['team']['teamLength'],
                        progressColor: const Color(0xff599068),
                        backgroundColor:
                            const Color(0xffF1EED0).withOpacity(0.3),
                      ),
                    ),
                    SizedBox(height: width(24)),
                    Center(
                      child: Text(
                        '${teamData.playersNeeded - team['team']['teamLength']} positions left of ${teamData.playersNeeded}',
                        style: TextStyle(
                          color: const Color(0xFFBFBCA0),
                          fontWeight: FontWeight.normal,
                          fontSize: width(14),
                        ),
                      ),
                    ),
                    SizedBox(height: width(35)),
                    Row(
                      children: [
                        SizedBox(width: width(22)),
                        Text(
                          'positions needed',
                          style: TextStyle(
                            color: const Color(0xFFBFBCA0),
                            fontWeight: FontWeight.w600,
                            fontSize: width(14),
                          ),
                        ),
                        SizedBox(width: width(20)),
                        if (teamData.positionsNeeded.isEmpty)
                          Text(
                            'any',
                            style: TextStyle(
                              color: const Color(0xFFA09F8D),
                              fontWeight: FontWeight.w600,
                              fontSize: width(12),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: width(24)),
                    Column(
                      children: teamData.positionsNeeded.isNotEmpty
                          ? List.generate(
                              teamData.positionsNeeded.length,
                              (index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width(33)),
                                        child: SizedBox(
                                          width: width(35),
                                          child: Center(
                                            child: Text(
                                              teamData.positionsNeeded[index],
                                              style: TextStyle(
                                                color: const Color(0xFF599068),
                                                fontWeight: FontWeight.w700,
                                                fontSize: width(14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width(15)),
                                      Text(
                                        positionsMap[teamData
                                                .positionsNeeded[index]] ??
                                            '',
                                        style: TextStyle(
                                          color: const Color(0xFFA09F8D),
                                          fontWeight: FontWeight.w400,
                                          fontSize: width(14),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: width(14)),
                                ],
                              ),
                            )
                          : [],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: width(25)),
            Padding(
              padding: EdgeInsets.only(left: width(22)),
              child: Text(
                'Joined Players',
                style: TextStyle(
                  color: const Color(0xFFF1EED0),
                  fontWeight: FontWeight.w600,
                  fontSize: width(14),
                ),
              ),
            ),
            SizedBox(height: width(20)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                      team['team']['joinedPlayers'].length,
                      (index) {
                        final playerData = team['team']['joinedPlayers'][index];
                        final player = {
                          'username' : playerData['username'],
                          'image' : playerData['image']
                        };
                        return Row(
                          children: [
                            SizedBox(width: width(7)),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PlayerProfile(playerData: player),
                                      ),
                                    );
                                  },
                                  child: Ink(
                                    child: Column(
                                      children: [
                                        ProfileCard(gameDataS : player),
                                        SizedBox(height: width(10)),
                                        Text(
                                          '${team['team']['joinedPlayers'][index]['playedGames']} games',
                                          style: TextStyle(
                                            color: const Color(0xFFF1EED0),
                                            fontSize: width(12),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        SizedBox(height: width(10)),
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/rateIcon.png',
                                                  width: width(20),
                                                  height: width(20),
                                                ),
                                                SizedBox(height: width(3)),
                                                Text(
                                                  '10',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFF1EED0),
                                                    fontSize: width(8),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: width(8)),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/motmIcon.png',
                                                  width: width(20),
                                                  height: width(20),
                                                ),
                                                SizedBox(height: width(3)),
                                                Text(
                                                  '5',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFFF1EED0),
                                                    fontSize: width(8),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: width(15)),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(width: width(7)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: width(50),
        color: member == false
            ? teamData.playersNeeded == teamData.members
                ? const Color(0xff599068)
                : sent == false
                    ? const Color(0xff599068)
                    : const Color(0xFF807E73)
            : owner == false
                ? const Color(0xff7E3C3C)
                : const Color(0xff599068),
        child: member == false
            ? teamData.playersNeeded == teamData.members
                ? TextButton(
                    onPressed: () {},
                    child: Text(
                      'bring your team and let\'s play',
                      style: TextStyle(
                        color: const Color(0xffF1EED0),
                        fontSize: width(16),
                        fontWeight:
                            sent == false ? FontWeight.w600 : FontWeight.w700,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      ref.read(sentProvider.notifier).sentPressed();
                    },
                    child: Text(
                      sent == false ? 'Send Request' : 'Cancel Request',
                      style: TextStyle(
                        color: sent == false
                            ? const Color(0xffF1EED0)
                            : const Color(0xFF292929),
                        fontSize: width(16),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
            : owner == false
                ? TextButton(
                    onPressed: () {},
                    child: Text(
                      'Leave Team',
                      style: TextStyle(
                        color: const Color(0xFF292929),
                        fontSize: width(16),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {},
                    child: Text(
                      'invite Players',
                      style: TextStyle(
                        color: const Color(0xffF1EED0),
                        fontSize: width(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
      ),
    );
  }
}
