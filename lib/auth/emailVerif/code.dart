import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Code extends StatefulWidget {
  const Code({super.key});

  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;
  late TextEditingController _firstController;
  late TextEditingController _secondController;
  late TextEditingController _thirdController;
  late TextEditingController _fourthController;

  @override
  void initState() {
    super.initState();
    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
    _firstController = TextEditingController();
    _secondController = TextEditingController();
    _thirdController = TextEditingController();
    _fourthController = TextEditingController();
    _addListeners();
  }

  @override
  void dispose() {
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();
    _firstController.dispose();
    _secondController.dispose();
    _thirdController.dispose();
    _fourthController.dispose();
    super.dispose();
  }

  void _addListeners() {
    _firstController.addListener(() {
      if (_firstController.text.length == 1) {
        _secondFocusNode.requestFocus();
      }
    });

    _secondController.addListener(() {
      if (_secondController.text.length == 1) {
        _thirdFocusNode.requestFocus();
      }
    });

    _thirdController.addListener(() {
      if (_thirdController.text.length == 1) {
        _fourthFocusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double a = 0;
    double screenWidth = MediaQuery.of(context).size.width;
    double width(double width) {
      a = width / 430;
      return screenWidth * a;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTextField(_firstFocusNode, _firstController, width),
        _buildTextField(_secondFocusNode, _secondController, width),
        _buildTextField(_thirdFocusNode, _thirdController, width),
        _buildTextField(_fourthFocusNode, _fourthController, width),
      ],
    );
  }

  Widget _buildTextField(FocusNode focusNode, TextEditingController controller,
      double Function(double) width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(width(20)),
      child: Container(
        width: width(40),
        height: width(40),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff599068),
            width: width(2),
          ),
          borderRadius: BorderRadius.circular(width(20)),
        ),
        child: Container(
          color: Colors.transparent,
          child: TextField(
            focusNode: focusNode,
            controller: controller,
            style: TextStyle(
                color: Color(0xff599068),
                fontSize: width(30),
                fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: '|',
              hintStyle: TextStyle(
                color: const Color(0xff599068),
                fontSize: width(24),
                fontWeight: FontWeight.w100,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 14.0),
              border: InputBorder.none,
              counterText: '',
            ),
            textAlign: TextAlign.center,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
        ),
      ),
    );
  }
}
