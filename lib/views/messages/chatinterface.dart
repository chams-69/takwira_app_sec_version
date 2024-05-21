import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takwira_app/views/messages/chat_list.dart';
import 'package:takwira_app/views/messages/sender.dart';
import 'package:takwira_app/views/playerProfile/player_profile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:url_launcher/url_launcher.dart';

class ChatInterface extends StatefulWidget {
  final dynamic? user;
  final IO.Socket? socket;
  const ChatInterface({this.user, super.key, this.socket});

  @override
  State<ChatInterface> createState() => _ChatInterfaceState();
}

class _ChatInterfaceState extends State<ChatInterface> {
  bool showIcons = true;
  FocusNode focusNode = FocusNode();
  TextEditingController text = TextEditingController();
  String myName = 'UserName1';
  dynamic user;
  String? userid;
  String? token;
  String? username;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
    setUserId();

    setState(() {
      user = widget.user;
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    // Initialize socket
    initializeSocket();
  }

  void initializeSocket() async {
    void handleMessageAck(data) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('id') ?? '';
      print('xddd');
      if ((data['senderId'] == id && data['receiverId'] == user['userId']) ||
          (data['senderId'] == user['userId'] && data['receiverId'] == id)) {
        setState(() {
          widget.user['messages'].add({
            'file': {'fileUrl': '', 'fileName': '', 'fileSize': ''},
            'senderId': data['senderId'],
            'receiverId': data['receiverId'],
            'content': data['content']
          });
        });
      }
      Future.delayed(Duration(milliseconds: 50), () {
        _scrollToBottom();
      });
      widget.socket?.off('new-mobile-message', handleMessageAck);
    }

    widget.socket?.on('new-mobile-message', handleMessageAck);
  }

  void sendMessage(String message) async {
    widget.socket!.emit('send-message', {
      'receiverId': user['userId'],
      'senderId': userid,
      'content': message,
      'filepath': '',
      'filename': '',
      'filesize': '',
    });

    Future.delayed(Duration(milliseconds: 50), () {
      _scrollToBottom();
    });
  }

  void setUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString('id') ?? '';
    var token = prefs.getString('token') ?? '';
    var username = prefs.getString('token') ?? '';
    setState(() {
      userid = id;
      token = token;
      username = username;
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff141815),
        iconTheme: const IconThemeData(color: Color(0xFFF1EED0)),
        title: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PlayerProfile(playerData: null),
              ),
            );
          },
          icon: Row(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Image.network(
                      '${user['userImageUrl']}',
                      width: 22,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 8),
              Text(
                '${user['username']}',
                style: TextStyle(
                  color: Color(0xFFF1EED0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/audioCall.png'),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/videoCall.png'),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/chatBg.png',
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.user['messages'].length,
                  itemBuilder: (_, index) {
                    final message = widget.user['messages'][index];
                    final isCurrentUser = message['senderId'] == userid;
                    final fileUrl = message['file']?['fileUrl'];
                    final fileName = message['file']?['fileName'];
                    bool isImage = false;
                    if (fileUrl != null) {
                      final fileExtension =
                          fileUrl.split('.').last.toLowerCase();
                      isImage = ['jpg', 'jpeg', 'png', 'gif', 'bmp']
                          .contains(fileExtension);
                    }

                    return Column(
                      crossAxisAlignment: isCurrentUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        if (fileUrl != null && isImage) ...[
                          Container(
                            margin: !isCurrentUser ? EdgeInsets.only(left: 18.0, top: 8.0) : EdgeInsets.only(right: 18.0, top: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                fileUrl,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8), 
                        ],
                        BubbleSpecialThree(
                          isSender: isCurrentUser,
                          text: message['content'].toString(),
                          color: isCurrentUser
                              ? Color(0xff599068)
                              : Color(0xff3D423E),
                          tail: false,
                          textStyle: TextStyle(
                            color: Color(0xffF1EED0),
                            fontSize: width(16),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: width(10)),
                child: Container(
                  color: Colors.transparent,
                  height: width(50),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width(30)),
                    child: Container(
                      width: width(388),
                      color: Color(0xff474D48),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              showIcons
                                  ? 'assets/images/cam.png'
                                  : 'assets/images/ball4.png',
                              width: width(35),
                              height: width(35),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: text,
                              focusNode: focusNode,
                              style: const TextStyle(color: Color(0xFFF1EED0)),
                              decoration: InputDecoration(
                                hintText: 'type a message',
                                hintStyle: TextStyle(
                                  color: const Color(0xFFA09F8D),
                                  fontSize: width(16),
                                  fontWeight: FontWeight.normal,
                                ),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  showIcons = value.isEmpty;
                                });
                              },
                            ),
                          ),
                          if (showIcons)
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/mic.png',
                                    width: width(27),
                                    height: width(27),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/image.png',
                                    width: width(29),
                                    height: width(29),
                                  ),
                                ),
                                SizedBox(width: width(7)),
                              ],
                            )
                          else
                            Padding(
                              padding: EdgeInsets.only(right: width(10)),
                              child: IconButton(
                                onPressed: () {
                                  sendMessage(text.text);
                                  setState(() {
                                    text.text = '';
                                    showIcons = true;
                                    focusNode.requestFocus();
                                  });
                                },
                                icon: Image.asset(
                                  'assets/images/send.png',
                                  width: width(30),
                                  height: width(30),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
