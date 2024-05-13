import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserData {
  final String id;
  final String username;
  final String fname;
  final String lname;
  final String email;
  final String phone;
  final bool verified;
  final String verificationToken;
  final String image;
  final String salt;
  final String hash;
  final DateTime birthdate;
  final String verificationResetCode;
  final String bio;
  final int rate;
  final int rated;
  final int motm;
  final int played;
  final int upcoming;
  final int posts;
  final int followersCount;
  final int followingCount;
  final int age;
  final int height;
  final int weight;
  final String post;
  final List<String> otherPosts;
  final int jerseyNumber;
  final String foot;

  UserData({
    required this.id,
    required this.username,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.verified,
    required this.verificationToken,
    required this.image,
    required this.salt,
    required this.hash,
    required this.birthdate,
    required this.verificationResetCode,
    required this.bio,
    required this.rate,
    required this.rated,
    required this.motm,
    required this.played,
    required this.upcoming,
    required this.posts,
    required this.followersCount,
    required this.followingCount,
    required this.age,
    required this.height,
    required this.weight,
    required this.post,
    required this.otherPosts,
    required this.jerseyNumber,
    required this.foot,
  });
}

final userDataProvider = Provider<UserData>((ref) {
  String fname = 'NAME';
  String username = 'User_Name';
  String bio = 'Bio description bla bla bla bla bla bla bla bla bla .';
  int rate = 99;
  int rated = 99;
  int motm = 99;
  int played = 99;
  int upcoming = 9;
  int posts = 99;
  int followersCount = 9999;
  int followingCount = 999;
  int age = 99;
  int height = 199;
  int weight = 99;
  String post = 'CM';
  List<String> otherPosts = ['CAM', 'LW'];
  int jerseyNumber = 99;
  String foot = 'Right';

  return UserData(
    id: '',
    username: username,
    fname: fname,
    lname: '',
    email: '',
    phone: '',
    verified: false,
    verificationToken: '',
    image: '',
    salt: '',
    hash: '',
    birthdate: DateTime.now(),
    verificationResetCode: '',
    bio: bio,
    rate: rate,
    rated: rated,
    motm: motm,
    played: played,
    upcoming: upcoming,
    posts: posts,
    followersCount: followersCount,
    followingCount: followingCount,
    age: age,
    height: height,
    weight: weight,
    post: post,
    otherPosts: otherPosts,
    jerseyNumber: jerseyNumber,
    foot: foot,
  );
});
