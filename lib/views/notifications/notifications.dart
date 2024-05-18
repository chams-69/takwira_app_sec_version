import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takwira_app/views/messages/chatinterface.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() =>_NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<dynamic> notifications = [];
  String? userid;
  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    fetchNotificationsData();
    initSocket();
  }

  void initSocket() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var tokenV = prefs.getString('token') ?? '';
    var usernameV = prefs.getString('username') ?? '';
    var id = prefs.getString('id') ?? '';
    socket = IO.io(
      'https://takwira.me/',
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'query': {
          'token': tokenV,
          'username': usernameV,
        },
      },
    );

    socket!.onConnect((_) {
      print('Connected to server');
    });

    socket!.on('new-mobile-messages', (data) {
      setState(() {
        int index = -1;
        for(int i= 0 ; i < notifications.length ; i++){
          dynamic? user = notifications[i];
          if((user['userId'] == data['senderId'] || user['userId'] == data['receiverId']) && user['userId'] !=id ){
            index = i;
            break;
          }
        }
        if (index != -1) {
          notifications[index]['messages'].add(data);
          var user = notifications.removeAt(index);
          notifications.insert(0, user);
        }
      });
    });
  }

  Future<void> fetchNotificationsData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('username') ?? '';
    var id = prefs.getString('id') ?? '';
    var token = prefs.getString('token') ?? '';
    if (username.isNotEmpty) {
      try {
        final response = await http.get(
            Uri.parse('https://takwira.me/api/notifications/data?username=$username'),
            headers: {
              'flutter': 'true',
              'authorization': token,
            });
        if (response.statusCode == 200) {
          final dataResponse = jsonDecode(response.body);
          setState(() {
            notifications = dataResponse['notifications'];
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
  void dispose() {
    socket!.off('new-mobile-messages');
    super.dispose();
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
      appBar: AppBar(
        backgroundColor: const Color(0xff343835),
        iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
        title: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Notifications',
            style: TextStyle(
              color: Color(0xFFF1EED0),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         ChatInterface(user: notifications[index], socket: socket),
                    //   ),
                    // );
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
                                    '${notifications[index]['owner']['image']}',
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
                          notifications[index]['owner']['username'],
                          style: TextStyle(
                              color: Color(0xffF1EED0),
                              fontSize: width(14),
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '${notifications[index]['notification']['content']}',
                          style: TextStyle(
                              color: Color.fromARGB(255, 179, 179, 179),
                              fontSize: width(9),
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          formatMessageTimestamp(notifications[index]['notification']['timestamp']),
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
