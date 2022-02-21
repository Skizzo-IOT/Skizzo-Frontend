import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

Color kScaffoldColor = Colors.white;
Color kTextColor = Colors.black;

Color kAppBarColor = Colors.orange[400]!;
const kPrimaryColor = Colors.white;
final kSecondaryColor = Colors.deepOrangeAccent[700]!;
const kButtonColor = Colors.white;
const kDisabledButtonColor = Color(0xFFE0E0E0);
final kDefaultBorderRadius = BorderRadius.circular(50);

// Server IP
const kServer = "10.0.2.2:8080";

//Query
const kDelayQuery = 100;
const kPasswordMaxLength = 25;

// Preferences name
const kTokenPref = "token";
const kEmailPref = "email";
const kPwdPref = "password";
const kSavePwd = "save_password";