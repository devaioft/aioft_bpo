import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFF0F0F0);
const kTextColor = Color(0xFF050505);
const kBtnColor = Color(0xFF0063DA);
const kCardColor = Color(0xFFFFFFFF);
const kIconTextColor = Color(0xFFB4B5C8);
const kIconColor = Color(0xFFFFF3DE);
const kIconEnabledColor = Color(0xFFFFF3DE);

const kNameStyle = TextStyle(
  fontSize: 16.5,
  fontWeight: FontWeight.bold,
);

const kCityTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 12.0,
);

const kDropDownMenuStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
);

var kElevatedButtonstyle = ElevatedButton.styleFrom(
  padding: const EdgeInsets.symmetric(vertical: 8.0),
  primary: kBtnColor,
  textStyle: const TextStyle(
      color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
);
