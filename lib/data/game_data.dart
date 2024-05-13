import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameData {
  final String id;
  final String gameName;
  final String gameOwner;
  final DateTime gameDateTime;
  final String gameTime;
  final List<String> joinedPlayers;
  final String reservationCode;
  final String fieldId;
  final List<String> requested;
  final int playersNeeded;
  final int members;
  final List<int> ageGroup;
  final String gameDescription;
  final List<String> positionsNeeded;
  final int requestedCount;
  final int joinedCount;
  final int invitedCount;

  GameData({
    required this.id,
    required this.gameName,
    required this.gameOwner,
    required this.gameDateTime,
    required this.gameTime,
    required this.joinedPlayers,
    required this.reservationCode,
    required this.fieldId,
    required this.requested,
    required this.playersNeeded,
    required this.members,
    required this.ageGroup,
    required this.gameDescription,
    required this.positionsNeeded,
    required this.requestedCount,
    required this.joinedCount,
    required this.invitedCount,
  });
}

final gameDataProvider = Provider<GameData>((ref) {
  String gameName = 'Takwira name';
  String gameOwner = 'user';
  DateTime gameDateTime = DateTime(2024, 5, 9);
  String gameTime = '21:00';
  int playersNeeded = 14;
  int members = 11;
  List<int> ageGroup = [18, 60];
  String gamedescription = 'bla bla bla bla bla bla bla bla bla bla bla bla ';
  List<String> positionsNeeded = ['GK', 'CDM', 'CM'];
  int requestedCount = 7;
  int joinedCount = 11;
  int invitedCount = 14;

  return GameData(
    id: '',
    gameName: gameName,
    gameOwner: gameOwner,
    gameDateTime: gameDateTime,
    gameTime: gameTime,
    joinedPlayers: [],
    reservationCode: '',
    fieldId: '1',
    requested: [],
    playersNeeded: playersNeeded,
    members: members,
    ageGroup: ageGroup,
    gameDescription: gamedescription,
    positionsNeeded: positionsNeeded,
    requestedCount: requestedCount,
    joinedCount: joinedCount,
    invitedCount: invitedCount,
  );
});
