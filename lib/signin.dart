import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/localStorage.dart';
 import 'package:flutter_application_1/mainHome.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn>{


 final TextEditingController _controllerEmail =TextEditingController();

  final TextEditingController _controllerPassword=TextEditingController();
  
String? errorMessage="";
Future<void> addToLocalStorage(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
  print('Data added to local storage');
}
LStorage lStorage = LStorage();
@override
  void initState() {
    super.initState();
    Auth().signOut();

  }
Future<Map<String, dynamic>> getUserData() async {
  User? user = FirebaseAuth.instance.currentUser;
  print('Userrrrrrrrrr: $user');
  print('UserrrrrrrrrrUID: ${user?.uid}');
  if (user?.uid != null) {
    
    // Reference to the user's document in the 'users' collection
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    // Check if the document exists
    if (snapshot.exists) {
      // Access user data
      Map<String, dynamic> userData = snapshot.data()!;
      print("userDataaaaa");
      print(userData);
      return userData;
    } else {
      print('User document does not exist');
      return {}; // or throw an exception, depending on your error handling strategy
    }
  } else {
    print('User is not signed in');
    return {}; // or throw an exception, depending on your error handling strategy
  }
  
}
  Future<void> signInWithEmailAndPassword() async {
try{
await Auth().signInWithEmailAndPassword(

email:_controllerEmail.text,

password: _controllerPassword.text,


) ;
getUserData().then((userData) async{
    print('User Data: $userData');
    String jsonMap = jsonEncode(userData);
    lStorage.addToLocalStorage('userData', jsonMap).then((value) => {
      print('S7iii7'),
       
});
  }).then((value) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            ));

} on FirebaseAuthException catch (e) {
  setState(() {
    if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
   content: Text('INVALID_LOGIN_CREDENTIALS'),
                  ));
    print('No user found for that email.');
  } 
    errorMessage = e.code;
    print(errorMessage);
});
  }}
   final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            
          );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Text(
                    'Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
              SizedBox(height: 100),
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  icon: Icon(Icons.email),
                  
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                  
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: ()  {
                      
                    },
                    child: Text(
                      'Forget your Password',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
         
    // Perform your sign-in logic here
    signInWithEmailAndPassword();
        },
                    child: Text('Log In'),
                  ),
                ],
              ),
              
              
              SizedBox(height: 20),
              Text(
                "You don't have an account?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


}