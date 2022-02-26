import 'package:flutter/material.dart';

final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

Color kScaffoldColor = Colors.grey[100]!;
Color kTextColor = Colors.black;

const kPrimaryColor = Colors.white;
const kSecondaryColor = Colors.blue;
const kActionColor = Color(0xFF0D47A1);

const kDisabledButtonColor = Color(0xFFE0E0E0);
final kDefaultBorderRadius = BorderRadius.circular(10);

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
