import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatData {
  final String id;
  List users = [];
  List chat = [];

  ChatData({
    required this.id,
    required this.users,
    required this.chat,
  });
}

final chatDataProvider = Provider<ChatData>((ref) {
  return ChatData(
    id: '',
    users: [],
    chat: [],
  );
});
