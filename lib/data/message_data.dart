import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageData {
  final String id;
  final String text;
  final String senderId;
  final DateTime time;

  MessageData({
    required this.id,
    required this.text,
    required this.senderId,
    required this.time,
  });
}

final messageDataProvider = Provider<MessageData>((ref) {
  return MessageData(
    id: '',
    text: '',
    senderId: '',
    time: DateTime.now(),
  );
});
