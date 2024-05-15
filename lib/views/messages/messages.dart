import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:linear_progress_bar/ui/dots_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takwira_app/views/messages/chatinterface.dart';
import 'package:http/http.dart' as http;

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  dynamic? reachedUsers;
  String? userid;

  @override
  void initState() {
    super.initState();
    fetchMessagesData();
  }

  Future<void> fetchMessagesData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username') ?? '';
    var id = prefs.getString('id') ?? '';
    var token = prefs.getString('token') ?? '';
    if (username.isNotEmpty) {
      try {
        final response = await http.get(
            Uri.parse(
                'https://takwira.me/api/messages/data?username=$username'),
            headers: {
              'flutter': 'true',
              'authorization': token,
            });
        if (response.statusCode == 200) {
          final dataResponse = jsonDecode(response.body);
          setState(() {
            reachedUsers = dataResponse['users'];
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
    double screenWidth = MediaQuery.of(context).size.width;
    double a = 0;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    double radius = screenWidth < 500 ? width(15) : 17.44186046511628;
    double sizedBoxWidth = screenWidth < 500 ? width(50) : 69.76744186046512;
    double activeAdd = screenWidth < 500 ? width(40) : 46.51162790697674;

    return Scaffold(
      backgroundColor: const Color(0xff343835),
      floatingActionButton: SizedBox(
        width: sizedBoxWidth,
        height: sizedBoxWidth,
        child: SpeedDial(
          backgroundColor: Colors.transparent,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          children: [
            SpeedDialChild(
              labelWidget: Container(
                padding: const EdgeInsets.all(7.0),
                decoration: BoxDecoration(
                  color: const Color(0xffF1EED0).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(width(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(14)),
                  child: Text(
                    'new Message',
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
                  color: const Color(0xffF1EED0).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(width(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width(14)),
                  child: Text(
                    'Create a Group',
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
          activeChild: Image.asset(
            'assets/images/addMessage.png',
            width: activeAdd,
            height: activeAdd,
          ),
          child: Image.asset(
            'assets/images/addMessage.png',
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff343835),
        iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Messages',
            style: TextStyle(
              color: Color(0xFFF1EED0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Ink(
              child: Image.asset(
                'assets/images/chatBot.png',
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: reachedUsers.length,
        itemBuilder: (context, index) {
          final messages = reachedUsers[index]['messages'];
          final dynamic lastMessageTimestamp =
              messages[messages.length - 1]['timestamp'];
          const int maxLength = 20;
          final String lastMessageContent =
              messages[messages.length - 1]['content'];
          final int messageLength = lastMessageContent.length;
          final bool isLastMessageFromCurrentUser = messages[messages.length - 1]['senderId'] == userid;
          String lastMessage;
          if (isLastMessageFromCurrentUser) {
            lastMessage = messageLength <= maxLength
                ? 'You : $lastMessageContent'
                : 'You : ${lastMessageContent!.substring(0, maxLength - 2)}...';
          } else {
            lastMessage = messageLength <= maxLength
                ? lastMessageContent!
                : '${lastMessageContent!.substring(0, maxLength - 2)}...';
          }
          if (reachedUsers[index]['userId'] == userid) {
            return Container();
          }

          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatInterface(user : reachedUsers[index]),
                ),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(width(10)),
                  child: ListTile(
                    leading: Stack(
                      children: [
                        SizedBox(
                          width: width(40),
                          height: width(40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width(25)),
                            child: Image.network(
                              '${reachedUsers[index]['userImageUrl']}',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reachedUsers[index]['username'],
                          style: TextStyle(
                              color: Color(0xffF1EED0),
                              fontSize: width(14),
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '$lastMessage',
                          style: TextStyle(
                              color: Color(0xffF1EED0),
                              fontSize: width(10),
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          formatMessageTimestamp(lastMessageTimestamp),
                          style: TextStyle(
                              color: Color(0xffBFBCA0),
                              fontSize: width(10),
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String formatMessageTimestamp(String timestamp) {
  DateTime messageTime = DateTime.parse(timestamp);

  DateTime now = DateTime.now();

  Duration difference = now.difference(messageTime);

  if (difference.inSeconds < 60) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} minutes ago';
  } else if (difference.inHours < 24 && now.day == messageTime.day) {
    return '${difference.inHours} hours ago';
  } else if (difference.inHours < 24 && now.day - 1 == messageTime.day) {
    return 'Yesterday at ${messageTime.hour}:${messageTime.minute}';
  } else {
    return '${_getDayName(messageTime.weekday)} ${messageTime.day} ${_getMonthName(messageTime.month)} ${messageTime.year} at ${_formatHour(messageTime.hour)}:${_formatMinute(messageTime.minute)}';
  }
}

String _getDayName(int day) {
  switch (day) {
    case 1:
      return 'Monday';
    case 2:
      return 'Tuesday';
    case 3:
      return 'Wednesday';
    case 4:
      return 'Thursday';
    case 5:
      return 'Friday';
    case 6:
      return 'Saturday';
    case 7:
      return 'Sunday';
    default:
      return '';
  }
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}

String _formatHour(int hour) {
  if (hour < 10) {
    return '0$hour';
  } else {
    return '$hour';
  }
}

String _formatMinute(int minute) {
  if (minute < 10) {
    return '0$minute';
  } else {
    return '$minute';
  }
}
