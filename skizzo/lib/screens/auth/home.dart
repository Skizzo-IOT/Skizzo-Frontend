import 'package:flutter/material.dart';
import 'package:skizzo/login.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: const [
              Text(
                "Skizzo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Image.asset(
            "assets/homepage.jpg",
            width: 500,
          ),
          SizedBox(
            width: 200,
            child: MaterialButton(
              height: 60,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text("Se connecter"),
            ),
          )
        ],
      ),
    );
  }
}
