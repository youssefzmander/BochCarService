import 'package:flutter/material.dart';
import 'package:flutter_application_1/signin.dart';

class Detailss extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
appBar: AppBar( title:Text("Details"), backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
            },
          ),
          ],) ,
        body: SafeArea(
          child: Column(
            
        ),
        ),
      ),
    );
  }


}