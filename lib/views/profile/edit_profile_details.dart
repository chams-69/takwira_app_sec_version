import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:takwira_app/data/user_data.dart';


class Right extends StateNotifier<bool> {
  Right() : super(true);
  void otherFoot() {
    state = !state;
  }
}

final footProvider = StateNotifierProvider<Right, bool>(((ref) {
  return Right();
}));

class EditProfileDetails extends ConsumerStatefulWidget {
  final VoidCallback toggleEditing;

  const EditProfileDetails({super.key, required this.toggleEditing});

  @override
  _EditProfileDetailsState createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends ConsumerState<EditProfileDetails> {
  String selectedPosition = '';
  List<String> availablePosition = [
    'GK',
    'CB',
    'RB',
    'LB',
    'CDM',
    'CM',
    'CAM',
    'RW',
    'LW',
    'ST'
  ];

  List<String> selectedPositions = [];
  List<String> availablePositions = [
    'GK',
    'CB',
    'RB',
    'LB',
    'CDM',
    'CM',
    'CAM',
    'RW',
    'LW',
    'ST'
  ];

  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(userDataProvider);
    final right = ref.watch(footProvider);
    final formKey = GlobalKey<FormState>();
    late String _height;
    late String _weight;
    late String _jerseyNumber;
    bool foot;

    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    final now = DateTime.now();
    int age = now.year - profileData.birthdate.year - 1;
    if (now.month >= profileData.birthdate.month) {
      if (now.day >= profileData.birthdate.day) {
        age++;
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(62)),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: width(30)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width(70)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width(20)),
                    border: Border.all(color: Color(0xFFBD4747)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width(10)),
                    child: IconButton(
                      onPressed: widget.toggleEditing,
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cancel Editing',
                            style: TextStyle(
                              color: Color(0xFFBD4747),
                              fontSize: width(14),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Image.asset(
                            'assets/images/cancelEdition.png',
                            width: width(16),
                            height: width(16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: width(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Age',
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: width(90),
                    child: Text(
                      '$age Years',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFFF1EED0),
                        fontSize: width(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: width(28)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Height',
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width(15)),
                    child: SizedBox(
                      width: width(60),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(
                                color: const Color(0xFFF1EED0),
                                fontSize: width(16),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              initialValue: '${profileData.height}',
                              decoration: InputDecoration(
                                counterText: '',
                              ),
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Height';
                                } else {
                                  int? height = int.tryParse(value);
                                  if (height == null ||
                                      height < 50 ||
                                      height > 250) {
                                    return 'Height should be enter 50 cm and 250 cm';
                                  }
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _height = value!;
                              },
                            ),
                          ),
                          SizedBox(width: width(5)),
                          Text(
                            'cm',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF1EED0),
                              fontSize: width(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: width(16)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weight',
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: width(15)),
                    child: SizedBox(
                      width: width(60),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(
                                color: const Color(0xFFF1EED0),
                                fontSize: width(16),
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              initialValue: '${profileData.weight}',
                              decoration: InputDecoration(
                                counterText: '',
                              ),
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your Weight';
                                } else {
                                  int? height = int.tryParse(value);
                                  if (height == null ||
                                      height < 20 ||
                                      height > 300) {
                                    return 'Height should be enter 20 cm and 300 cm';
                                  }
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _weight = value!;
                              },
                            ),
                          ),
                          SizedBox(width: width(5)),
                          Text(
                            'Kg',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFF1EED0),
                              fontSize: width(16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: width(27)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Foot',
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        ref.read(footProvider.notifier).otherFoot();
                      },
                      child: right == true
                          ? Row(
                              children: [
                                Transform.rotate(
                                  angle: 30 * (3.141592653589793 / 180),
                                  child: Image.asset(
                                    'assets/images/right.png',
                                    width: width(30),
                                    height: width(30),
                                  ),
                                ),
                                SizedBox(width: width(10)),
                                Text(
                                  'Right',
                                  style: TextStyle(
                                    color: const Color(0xFFF1EED0),
                                    fontSize: width(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Text(
                                  'Left',
                                  style: TextStyle(
                                    color: const Color(0xFFF1EED0),
                                    fontSize: width(16),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: width(10)),
                                Transform.rotate(
                                  angle: -30 * (3.141592653589793 / 180),
                                  child: Image.asset(
                                    'assets/images/left.png',
                                    width: width(30),
                                    height: width(30),
                                  ),
                                ),
                              ],
                            )),
                ],
              ),
              SizedBox(height: width(39)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jersey Number',
                    style: TextStyle(
                      color: const Color(0xFFF1EED0),
                      fontSize: width(16),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Row(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/jerseyNumber.png',
                            width: width(50),
                            height: width(50),
                          ),
                          Positioned(
                            top: width(1),
                            left: width(1),
                            child: SizedBox(
                              width: width(50),
                              child: TextFormField(
                                style: TextStyle(
                                  color: const Color(0xFFF1EED0),
                                  fontSize: width(16),
                                  fontWeight: FontWeight.w900,
                                ),
                                textAlign: TextAlign.center,
                                initialValue: '${profileData.jerseyNumber}',
                                decoration: InputDecoration(
                                  counterText: '',
                                ),
                                maxLength: 2,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your Jersey number';
                                  } else {
                                    int? jersyNumber = int.tryParse(value);
                                    if (jersyNumber == null ||
                                        jersyNumber < 1 ||
                                        jersyNumber > 99) {
                                      return 'Jersey number should be enter 1 and 99';
                                    }
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _jerseyNumber = value!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: width(15)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: width(40)),
              SizedBox(
                width: width(screenWidth),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(width(9)),
                      ),
                      foregroundColor: const Color(0xFFF1EED0),
                      backgroundColor: const Color(0xFF599068),
                      padding: EdgeInsets.symmetric(
                          horizontal: width(15), vertical: width(20)),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        widget.toggleEditing();
                        foot = right;
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: width(12),
                      ),
                    )),
              ),
              SizedBox(height: width(20)),
            ],
          ),
        ),
      ),
    );
  }
}