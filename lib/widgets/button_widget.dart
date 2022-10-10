// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';


// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {

  var btnText;
  var onClick;


  ButtonWidget({Key? key, this.btnText, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF1592ff), Color(0xff1592ff)],
              end: Alignment.centerLeft,
              begin: Alignment.centerRight),
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          btnText,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}