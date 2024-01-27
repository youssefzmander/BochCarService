



import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/mainHome.dart';
import 'package:flutter_application_1/signin.dart';

class WidgetTree extends StatefulWidget {

//const WidgetTree({Key? key}) : super (key: key);

@override
_WidgetTreeState createState() => _WidgetTreeState();

}

class _WidgetTreeState extends State<WidgetTree>{
  @override
  

  Widget build(BuildContext context) {
    return StreamBuilder(stream: Auth().authStateChanges, 
    builder: (context, snapshot) {
      if (snapshot.hasData){
        print("GOOOOOOOOOOOOO");
        print(snapshot.data?.uid);
        return BottomNavigation();
      }
      else{
         print("Chyeeeee7");
        return SignIn();
      }
    });
  }

}