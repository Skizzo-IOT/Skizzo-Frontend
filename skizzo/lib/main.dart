import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: SafeArea(
       child: Container(
         //double.infinity make it big as the parent allows
         width: double.infinity,
         height: MediaQuery.of(context).size.height,
         padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Column(
               children: <Widget>[
                 Text("Skizzo", 
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
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/homepage.jpg")
                )
              ),
            ),
            
            Column(
              children: <Widget>[
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  }, 
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(50)
                ),
                )
              ],
            ) 
           ],
         ),
        )
      )
   );
  }
}
