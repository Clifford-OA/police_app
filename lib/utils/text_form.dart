import 'package:flutter/material.dart';

Widget textInput({controller, hint, formatters, icon}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    padding: const EdgeInsets.only(left: 10),
    child: TextFormField(
        inputFormatters: formatters,
        // initialValue: initialValue,
        controller: controller,
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon),
          ),
          border: InputBorder.none,
          labelText: hint,
        )),
  );
}

Widget textInputPassword(
    {obscureValue, onPressedSuffixIcon, suffixIcon, controller, hint, icon}) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: Colors.white,
    ),
    padding: const EdgeInsets.only(left: 10),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon),
          ),
          border: InputBorder.none,
          labelText: hint,
          suffixIcon: IconButton(
            icon: suffixIcon,
            onPressed: onPressedSuffixIcon,
          )),
      obscureText: obscureValue,
    ),
  );
}
