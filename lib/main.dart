import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/notification.dart';
import 'package:flutter_application_1/signin.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
await PushNotificationService().initialize();
  
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Bosh Car service',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
        '/SignUp': (context) => SignUp(), // SignUp route
        '/SignIn': (context) => SignIn(), // SignUp route
      },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}


 class MyHomePage extends StatefulWidget { 
  @override 
  _MyHomePageState createState() => _MyHomePageState(); 
} 
class _MyHomePageState extends State<MyHomePage> { 
  @override 
  void initState() { 
    super.initState(); 
    Timer(Duration(seconds: 3), 
   ()=>Navigator.pushReplacement(context, 
     MaterialPageRoute(builder: 
    (context) =>   SignIn()    ) 
 ) 
         ); 
  } 
  @override 
  Widget build(BuildContext context) { 
    return Container( 
      color: const Color.fromARGB(255, 94, 81, 81), 
      //child:FlutterLogo( size:MediaQuery.of(context).size.height) 
    child: Image.asset(
            'assets/BOSCH.png', // Path to your image asset
            width: double.infinity, // Set width to fill the entire width
            height: 200, // Adjust height as needed
            //fit: BoxFit.cover, // Adjust how the image is displayed
          ),
    ); 
  } 
} 