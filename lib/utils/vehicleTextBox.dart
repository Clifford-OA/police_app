

// ignore_for_file: file_names

 import 'package:flutter/material.dart';

vehiclenumberformtextBox(validator, focus, keyboardType, controller,
      labelText, hintText, maxLenght, inputformatter) {
    return TextFormField(
      inputFormatters: inputformatter,
      validator: validator,
      focusNode: focus,
      maxLength: maxLenght,
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.characters,
      controller: controller,
      decoration: InputDecoration(
          counterText: '',
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText),
    );
  }