import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeamData {
  final String id;
  final String teamName;
  final String teamLeader;
  final List<String> joinedPlayers;
  final String groupId;
  final Color teamColor;
  final String formation;
  final String teamDescription;
  final int playersNeeded;
  final int members;
  final List<int> ageGroup;
  final List<String> positionsNeeded;

  TeamData({
    required this.id,
    required this.teamName,
    required this.teamLeader,
    required this.joinedPlayers,
    required this.groupId,
    required this.teamColor,
    required this.formation,
    required this.teamDescription,
    required this.playersNeeded,
    required this.members,
    required this.ageGroup,
    required this.positionsNeeded,
  });
}

final teamDataProvider = Provider<TeamData>((ref) {
  String teamName = 'Team name';
  String teamDescription = 'We"re looking for an apponent to play against us';
  int playersNeeded = 7;
  int members = 5;
  List<int> ageGroup = [18, 60];
  List<String> positionsNeeded = ['RB', 'CAM', 'LW'];
  String teamLeader = 'user';

  return TeamData(
    id: '',
    teamName: teamName,
    teamLeader: teamLeader,
    joinedPlayers: [],
    groupId: '',
    teamColor: Colors.green,
    formation: '',
    teamDescription: teamDescription,
    playersNeeded: playersNeeded,
    members: members,
    ageGroup: ageGroup,
    positionsNeeded: positionsNeeded,
  );
});
