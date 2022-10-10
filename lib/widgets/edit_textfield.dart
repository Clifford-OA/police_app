import 'package:flutter/material.dart';

Widget textfield({@required hintText, onChanged, formatters, TextInputType? inputType}) {
    return Material(
      elevation: 3,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        inputFormatters: formatters,
        onChanged: onChanged,
        keyboardType: inputType,
            // hintText == 'tel' ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              letterSpacing: 2,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
            fillColor: Colors.white30,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none)),
      ),
    );
  }
