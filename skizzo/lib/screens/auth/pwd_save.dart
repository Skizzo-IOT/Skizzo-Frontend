import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skizzo/constants.dart';

class PwdSave extends StatefulWidget {
  const PwdSave({Key? key}) : super(key: key);

  @override
  _PwdSaveState createState() => _PwdSaveState();
}

class _PwdSaveState extends State<PwdSave> {
  bool isChecked = false;

  _dataRetriever() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isChecked = prefs.getBool(kSavePwd) ?? false;
    });
  }

  @override
  void initState() {
    super.initState();

    _dataRetriever();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
              SharedPreferences.getInstance()
                  .then((prefs) => prefs.setBool(kSavePwd, value));
            });
          },
        ),
        const Expanded(
          child: Text(
            "Sauvegarder le mot de passe ?",
            style: TextStyle(
              color: Color(0xFF263238),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
