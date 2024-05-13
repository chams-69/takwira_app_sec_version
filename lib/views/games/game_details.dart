import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:takwira_app/data/field_data.dart';
import 'package:takwira_app/data/game_data.dart';
import 'package:takwira_app/data/user_data.dart';
import 'package:takwira_app/providers/sent.dart';
import 'package:takwira_app/views/cards/profile_card.dart';
import 'package:takwira_app/views/playerProfile/player_profile.dart';

final sentProvider = StateNotifierProvider<Sent, bool>(((ref) {
  return Sent();
}));

class GameDetails extends ConsumerWidget {
  final dynamic? gameDataS;
  const GameDetails({Key? key, required this.gameDataS});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    print(gameDataS);

    final gameData = ref.watch(gameDataProvider);
    final fieldData = ref.watch(fieldDataProvider);
    final playerData = ref.watch(userDataProvider);
    final sent = ref.watch(sentProvider);
    bool member = true;
    bool owner = true;

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

    final gameDate = DateTime.parse(gameDataS['game']['date']);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final yesterday = today.subtract(Duration(days: 1));
    final date = gameDate;
    final soon = date.difference(now).inDays;
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    String time = gameData.gameTime.length == 4
        ? '0${gameData.gameTime}'
        : gameData.gameTime;

    final dateTime = DateTime.parse('${date.year}-$month-$day $time');

    return Scaffold(
      backgroundColor: const Color(0xff343835),
      appBar: AppBar(
        backgroundColor: const Color(0xff343835),
        iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Game details',
            style: TextStyle(
              color: Color(0xFFF1EED0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          if (owner == true)
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/edit.png'),
            ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/share.png'),
          ),
          const SizedBox(width: 5)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: width(15)),
            if (owner == true)
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width(80)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: width(40),
                              height: width(40),
                              decoration: BoxDecoration(
                                color: Color(0xff474D48),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Center(
                                child: Text(
                                  '${gameData.requestedCount}',
                                  style: TextStyle(
                                    color: Color(0xFFF1EED0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: width(5)),
                            Text(
                              'Requested',
                              style: TextStyle(
                                color: Color(0xFFA09F8D),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: width(40),
                              height: width(40),
                              decoration: BoxDecoration(
                                color: Color(0xff474D48),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Center(
                                child: Text(
                                  '${(gameData.playersNeeded -gameDataS['game']['playersLeft']).toInt()}',
                                  style: TextStyle(
                                    color: Color(0xFFF1EED0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: width(5)),
                            Text(
                              'Joined',
                              style: TextStyle(
                                color: Color(0xFFA09F8D),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: width(40),
                              height: width(40),
                              decoration: BoxDecoration(
                                color: Color(0xff474D48),
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Center(
                                child: Text(
                                  '${gameData.invitedCount}',
                                  style: TextStyle(
                                    color: Color(0xFFF1EED0),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: width(5)),
                            Text(
                              'invited',
                              style: TextStyle(
                                color: Color(0xFFA09F8D),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: width(20)),
                ],
              ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(21)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width(2)),
                        child: SizedBox(
                          width: width(388),
                          height: owner == true ? width(200) : width(226),
                          child: Image.asset(
                            'assets/images/gameBg.png',
                            fit: BoxFit.cover,
                            opacity: const AlwaysStoppedAnimation(0.6),
                          ),
                        ),
                      ),
                      Positioned(
                        top: width(23),
                        child: Row(
                          children: [
                            Container(
                              width: width(104),
                              height: width(21),
                              decoration: BoxDecoration(
                                color: const Color(0xFF599068)
                                    .withOpacity(0.6), // Green color
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(width(3)),
                                  bottomRight: Radius.circular(width(3)),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    width(13), width(3), 0, 0),
                                child: Text(
                                  date.isAtSameMomentAs(today)
                                      ? 'Today, ${DateFormat.jm().format(dateTime)}'
                                      : date.isAtSameMomentAs(yesterday)
                                          ? 'Yesterday, ${DateFormat.jm().format(dateTime)}'
                                          : date.isAtSameMomentAs(tomorrow)
                                              ? 'Tomorrow, ${DateFormat.jm().format(dateTime)}'
                                              : date.isAfter(now) && soon < 7
                                                  ? '${DateFormat('EEEE').format(date)}, ${DateFormat.jm().format(dateTime)}'
                                                  : DateFormat(
                                                          'EEE, d MMM, yyyy')
                                                      .format(date),
                                  style: TextStyle(
                                    color: const Color(0xFFF1EED0),
                                    fontSize: width(10),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width(239)),
                            Stack(
                              children: [
                                Image.asset(
                                  'assets/images/age.png',
                                  width: width(30),
                                  height: width(30),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      width(4), width(5), 0, 0),
                                  child: Text(
                                    '${gameData.ageGroup[0]}',
                                    style: TextStyle(
                                      color: const Color(0xFFF1EED0),
                                      fontSize: width(14),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/linear3.png',
                  width: screenWidth,
                  height: owner == false ? width(236) : width(200),
                  fit: BoxFit.cover,
                ),
                Column(
                  children: [
                    SizedBox(height: width(62)),
                    Center(
                      child: Text(
                        gameData.gameName,
                        style: TextStyle(
                          color: const Color(0xFFF1EED0),
                          fontSize: width(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: owner == true ? width(15) : width(8)),
                    Text(
                      DateFormat('d MMMM, yyyy').format(date),
                      style: TextStyle(
                        color: const Color(0xffF1EED0),
                        fontWeight: FontWeight.w600,
                        fontSize: width(16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${gameDataS['field']['price']} DNT',
                      style: TextStyle(
                        color: const Color(0xffF1EED0),
                        fontWeight: FontWeight.w600,
                        fontSize: width(16),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: width(20)),
                    if (owner == false)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width(41)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: width(2)),
                              child: Row(
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
                                          child: Image.asset(
                                            'assets/images/avatar.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: width(5)),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Text(
                                            'Organizer',
                                            style: TextStyle(
                                              color: const Color(0xFF599068),
                                              fontSize: width(9),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(top: width(1)),
                                            child: Text(
                                              'Organizer',
                                              style: TextStyle(
                                                color: const Color(0xFF599068),
                                                fontSize: width(9),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                width(1.14), width(0.5), 0, 0),
                                            child: Text(
                                              'Organizer',
                                              style: TextStyle(
                                                color: const Color(0xFFF1EED0),
                                                fontSize: width(9),
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        gameData.gameOwner,
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
                            ),
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
            if (member == true)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(95)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/announcement.png',
                        width: width(40),
                        height: width(40),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/gamechat.png',
                        width: width(30),
                        height: width(31.06),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/teamsSort.png',
                        width: width(65.5),
                        height: width(43),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: width(5)),
            Stack(
              children: [
                SizedBox(
                  width: screenWidth,
                  height: gameData.positionsNeeded.isEmpty
                      ? width(250)
                      : width(250 + gameData.positionsNeeded.length * 34),
                  child: Image.asset(
                    'assets/images/linear5.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: width(103),
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
                    SizedBox(height: width(14)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width(21)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              color: const Color(0xFFBFBCA0),
                              fontSize: width(14),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: width(22)),
                              Text(
                                gameData.gameDescription,
                                style: TextStyle(
                                  color: const Color(0xFFF1EED0),
                                  fontSize: width(14),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: width(61)),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width(41), 0, width(82), 0),
                      child: LinearProgressBar(
                        maxSteps: gameData.playersNeeded,
                        progressType: LinearProgressBar
                            .progressTypeLinear, // Use Linear progress
                        currentStep: (gameData.playersNeeded -gameDataS['game']['playersLeft']).toInt(),
                        progressColor: const Color(0xff599068),
                        backgroundColor:
                            const Color(0xffF1EED0).withOpacity(0.3),
                      ),
                    ),
                    SizedBox(height: width(24)),
                    Center(
                      child: Text(
                        '${gameDataS['game']['playersLeft']} positions left of ${gameData.playersNeeded}',
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
                        if (gameData.positionsNeeded.isEmpty)
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
                      children: gameData.positionsNeeded.isNotEmpty
                          ? List.generate(
                              gameData.positionsNeeded.length,
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
                                              gameData.positionsNeeded[index],
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
                                        positionsMap[gameData
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
                      (gameData.playersNeeded -gameDataS['game']['playersLeft']).toInt(),
                      (index) {
                        print('wawawaw ${gameDataS['game']['playersLeft']}');
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
                                            PlayerProfile(playerData : gameDataS['game']['joinedPlayers'][index]),
                                      ),
                                    );
                                  },
                                  child: Ink(
                                      child: Column(
                                    children: [
                                      ProfileCard(gameDataS : gameDataS['game']['joinedPlayers'][index]),
                                      SizedBox(height: width(10)),
                                      Text(
                                        '${playerData.played} games',
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
                                                '${playerData.rated}',
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
                                                '${playerData.motm}',
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
                                  )),
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
            ? gameData.playersNeeded == gameData.members
                ? const Color(0xFF807E73)
                : sent == false
                    ? const Color(0xff599068)
                    : const Color(0xFF807E73)
            : owner == false
                ? const Color(0xff7E3C3C)
                : const Color(0xff599068),
        child: member == false
            ? gameData.playersNeeded == gameData.members
                ? TextButton(
                    onPressed: () {},
                    child: Text(
                      'This game is completly full',
                      style: TextStyle(
                        color: const Color(0xFF292929),
                        fontSize: width(16),
                        fontWeight: FontWeight.w700,
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
                        fontWeight:
                            sent == false ? FontWeight.w600 : FontWeight.w700,
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
