import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTextField extends StatefulWidget {
  final String text;
  final IconData? icon;
  final TextEditingController controller;
  final bool isLocked;
  final bool isObligatory;
  final bool isNumeric;
  final int maxCharacters;
  final int minCharacters;
  final bool isPassword;
  final bool isEmail;
  final bool isDatePicker;
  final double fontSize;
  final double iconSize;

  const MyTextField(
      {required this.text,
      required this.icon,
      required this.controller,
      this.isLocked = false,
      this.isObligatory = true,
      this.isNumeric = false,
      this.maxCharacters = 255,
      this.minCharacters = 0,
      this.isPassword = false,
      this.isDatePicker = false,
      this.isEmail = false,
      this.fontSize = 16,
      this.iconSize = 25,
      Key? key})
      : super(key: key);

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  DateTime _selectedDate = DateTime.now();
  late bool _obscureText = widget.isPassword;

  _emailRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    widget.controller.text = email;
  }

  @override
  void initState() {
    super.initState();

    if (widget.isEmail) {
      _emailRetriever();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  size: widget.iconSize,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : widget.icon != null
                ? Icon(
                    widget.icon,
                    size: widget.iconSize,
                  )
                : null,
        labelText: widget.text,
        border: const OutlineInputBorder(),
        fillColor: widget.isLocked ? Colors.grey[300] : Colors.white,
        filled: true,
        counterText: widget.isNumeric |
                widget.isDatePicker |
                widget.isEmail |
                widget.isPassword
            ? ""
            : null,
        isDense: true,
      ),
      enabled: !widget.isLocked,
      keyboardType: widget.isEmail
          ? TextInputType.emailAddress
          : widget.isNumeric
              ? TextInputType.number
              : TextInputType.text,
      inputFormatters:
          widget.isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
      focusNode: widget.isDatePicker ? AlwaysDisabledFocusNode() : null,
      maxLength: widget.maxCharacters,
      obscureText: _obscureText,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: widget.fontSize,
      ),
      onTap: () {
        if (widget.isDatePicker) {
          _selectDate(context);
        }
      },
      controller: widget.controller,
      validator: (value) => validateField(value!),
      onSaved: (value) {
        if (widget.isEmail) {
          SharedPreferences.getInstance()
              .then((prefs) => prefs.setString('email', value!));
        }
      },
    );
  }

  String? validateField(String value) {
    if (widget.isObligatory && value.isEmpty) {
      return "* Champs Requis";
    }

    if (value.length > widget.maxCharacters) {
      return "Il y a trop de caractères (${value.length - widget.maxCharacters} en trop)";
    }

    if (value.isNotEmpty && value.length < widget.minCharacters) {
      return "Ce champs nécessite au moins ${widget.minCharacters} caractères";
    }

    // if (!emailValidatorRegExp.hasMatch(value)) {
    //   return "Veuillez entrer un email valide.";
    // }

    if (widget.isNumeric) {
      try {
        int.parse(widget.controller.text);
      } on Exception {
        return "Valeur trop grande.";
      }
    }

    return null;
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child!,
          );
        });

    _selectedDate = newSelectedDate!;
    widget.controller
      ..text = DateFormat("yyyy-MM-dd").format(_selectedDate)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: widget.controller.text.length,
          affinity: TextAffinity.upstream));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}