import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RoundedButton({
    required this.buttonName,
    this.action,
  });

  final String buttonName;
  // ignore: prefer_typing_uninitialized_variables
  final action;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xff5663ff),
      ),
      child: OutlinedButton(
        onPressed: action, // => Navigator.pushNamed(context, 'HomeScreen'),
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 22, color: Colors.white, height: 1.5)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
