import 'package:flutter/material.dart';

class FormFieldItem {
  final int id;
  final String text;

  FormFieldItem(this.id, this.text);

  @override
  String toString() {
    return "Id: $id, text: $text";
  }

  @override
  bool operator ==(Object other) => other is FormFieldItem && other.id == id;

  @override
  int get hashCode => id.hashCode;
}

// ignore: must_be_immutable
class MyFormField extends StatefulWidget {
  final List<FormFieldItem> items;
  final String text;
  final bool isLocked;
  final IconData? icon;
  final Function(FormFieldItem?) onChangedValue;

  const MyFormField({
    Key? key,
    required this.items,
    required this.onChangedValue,
    required this.text,
    this.isLocked = false,
    this.icon,
  }) : super(key: key);

  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        suffixIcon: widget.icon != null ? Icon(widget.icon) : null,
        labelText: widget.text,
        border: const OutlineInputBorder(),
        fillColor: widget.isLocked ? Colors.grey[300] : Colors.white,
        filled: true,
        isDense: true,
      ),
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontSize: 16,
      ),
      onChanged: (FormFieldItem? value) {
        widget.onChangedValue(value);
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: validateField,
      items: widget.items
          .map((e) => DropdownMenuItem(
                child: Text(e.text),
                value: e,
              ))
          .toList(),
    );
  }

  String? validateField(FormFieldItem? value) {
    if (value == null) {
      return "* Champs Requis";
    }

    return null;
  }
}