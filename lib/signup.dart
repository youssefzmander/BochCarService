
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
  final List<String> _choices = ['TU', 'RS', 'FCR', 'DOUANE', 'ETAT', 'AUTRES'];
  late String? _selectedChoice= "TU";
  late String? _Plate3="";//
  late String? _Plate4="";//
  late String? _eemail="";//
  late String? _uuserName="";//
  late String? _Tel="";
  late String? _MDP="";
  late String? _MDP2="";
  late String Plate= "";
  String? errorMessage="";
  bool PassCorrect = false;
    final TextEditingController _controllerEmail =TextEditingController();

  final TextEditingController _controllerPassword=TextEditingController();
  Future<String?> getFromLocalStorage(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
Future<void> addUserDataToFirestore() async {
  // Get the current authenticated user
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Reference to the user's document in the 'users' collection
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    // Define user data to be stored in Firestore
    Map<String, dynamic> userData = {
      'UserName': _uuserName,
    'Email': _eemail,
    'Tel': _Tel,
    'Password': _MDP2,
    'Plate': Plate,
    'Plate3': _Plate3,
    'Plate4': _Plate4,
      // Add other user-related fields as needed
    };

    // Set the data in Firestore
    await userDocRef.set(userData);

    print('User data added to Firestore for UID: ${user.uid}');
  } else {
    print('User is not signed in');
  }
}
 
  
  Future<void> createUserwithEmailAndPassword() async {
try{
await Auth().createUserWithEmailAndPassword(

email:_controllerEmail.text,

password: _controllerPassword.text,


) ;
} on FirebaseAuthException catch (e) {
  setState(() {errorMessage = e.message;
  print(errorMessage);
});
  }}
  
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register Account',
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
                  ),
                  Text(
                    'Register Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
              SizedBox(height: 20),
              
              
              SizedBox(height: 20),
              TextField(
              onChanged: (String? uuserName) {
            setState(() {
              _uuserName = uuserName!;
            });
            print('user Name: $uuserName');
          },
                decoration: InputDecoration(
                  
                  labelText: 'Full Name',
                  icon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controllerEmail,
                onChanged: (String? eemail) {
            setState(() {
              _eemail = eemail!;
            });
            print('email: $eemail');
            print('controller: $_controllerEmail.text ');
          },
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  icon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 20),
              Text(
                    'Plate Number',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  
             Padding(
  padding: EdgeInsets.only(left: 5.0), // Adjust the left padding as needed
  child: Row(
   // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment as needed
    children: [
      Expanded(
        child: TextField(
          enabled: _selectedChoice == 'TU',
          onChanged: (String? Plate03) {
            setState(() {
              _Plate3 = Plate03!;
            });
            print('Plate03: $Plate03');
          },
          decoration: InputDecoration(
            labelText: '3 Degit',
            icon: Icon(Icons.numbers),
          ),
        ),
      ),
      Expanded(
        
    
     // Set the desired fixed width
        child: DropdownButton<String>(
          value: _selectedChoice,
          onChanged: (String? newValue) {
            setState(() {
              _selectedChoice = newValue!;
            });
            print('Selected: $newValue');
          },
          items: _choices.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        
      ),
      Expanded(
        child: TextField(
          onChanged: (String? Plate04) {
            setState(() {
              _Plate4 = Plate04!;
            });
            print('Plate03: $Plate04');
          },
          decoration: InputDecoration(
            labelText: '4 Degit',
            icon: Icon(Icons.numbers),
          ),
        ),
      ),
      SizedBox(width: 50),
    ],
  ),
),
              
              TextField(
                onChanged: (String? Tel ) {
            setState(() {
              _Tel = Tel!;
            });
            print('email: $Tel');
          },
                decoration: InputDecoration(
                  labelText: 'TEL',
                  icon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                onChanged: (String? MDP ) {
            setState(() {
              _MDP = MDP!;
            });
            print('email: $MDP');
          },
          obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  icon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                controller: _controllerPassword,
                onChanged: (String? MDP2 ) {
            setState(() {
              if (MDP2==_MDP){
              _MDP2 = MDP2!;
              PassCorrect= true;
              }else{
                PassCorrect= false;
              }
              
            });
            print('email: $MDP2');
          },
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  icon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('error: $errorMessage');
                  print(_Plate3);
                  Plate=  _Plate4!+ _selectedChoice!+ _Plate3!;
                  print(Plate);
                  
                  if (PassCorrect==true){
                    createUserwithEmailAndPassword();
                    print("TLA3333");
                    FirebaseAuth.instance.authStateChanges().listen((User? user) {
  if (user != null) {
    // User is signed in
    addUserDataToFirestore();
  } else {
    // User is signed out
    print('User is signed out');
  }
});
                    
                    PassCorrect=false;
                  }else{
                    print("rodha toast:wrong password");
                  }
                  

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
          },
                child: Text('CONTINUE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}