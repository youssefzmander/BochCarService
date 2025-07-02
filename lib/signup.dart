import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final List<String> _choices = ['TU', 'RS', 'FCR', 'DOUANE', 'ETAT', 'AUTRES'];
  late String? _selectedChoice = "TU";
  late String? _Plate3 = ""; //
  late String? _Plate4 = ""; //
  late String? _eemail = ""; //
  late String? _uuserName = ""; //
  late String? _Tel = "";
  late String? _MDP = "";
  late String? _MDP2 = "";
  late String Plate = "";
  String? errorMessage = "";
  bool PassCorrect = false;
  final TextEditingController _controllerEmail = TextEditingController();

  final TextEditingController _controllerPassword = TextEditingController();
  bool _isTelValid = false;
  bool _plate3Touched = false;
  bool _plate4Touched = false;
  bool _telTouched = false;

  Future<String?> getFromLocalStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> addUserDataToFirestore() async {
    try {
      // Get the current authenticated user
      User? user = FirebaseAuth.instance.currentUser;
      print("user : $user");
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
          'MatType': _selectedChoice,
          // Add other user-related fields as needed
        };
        print('User data : ${userData}');
        // Set the data in Firestore
        await userDocRef
            .set(userData)
            .then((value) => {
                  userData = {},
                  print('User data added to Firestore for UID: ${user.uid}')
                })
            .then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                ));

        print('User data added to Firestore for UID: ${user.uid}');
      } else {
        print('User is not signed in');
      }
    } catch (e) {
      print("probleme: ${e.toString()}");
    }
  }

  Future<void> createUserwithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Padding(
              padding: EdgeInsets.only(bottom: 10), // Add bottom margin here
              child: Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ), // Change font size here
              ),
            ),
            backgroundColor: const Color.fromARGB(
                255, 207, 62, 52), // Change background color here
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Change shape here
            ),
          ),
        );
        print("errrrrror : $errorMessage");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: SingleChildScrollView(
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
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controllerEmail,
                  onChanged: (String? eemail) {
                    setState(() {
                      _eemail = eemail!;
                    });
                    print('email: $eemail');
                    print('controller: ${_controllerEmail.text}');
                  },
                  decoration: InputDecoration(
                    labelText: 'Your Email',
                    icon: Icon(Icons.email),
                    errorText: _eemail != null &&
                            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_eemail!)
                        ? 'Enter a valid email'
                        : null,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                Text(
                  'Plate Number',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 5.0), // Adjust the left padding as needed
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 30.0),
                                child: TextField(
                                  enabled: _selectedChoice == 'TU',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(3),
                                  ],
                                  onChanged: (String? Plate03) {
                                    setState(() {
                                      _Plate3 = Plate03!;
                                    });
                                    print('Plate03: $Plate03');
                                  },
                                  decoration: InputDecoration(
                                    labelText: '3 Digit',
                                    errorText: null,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: DropdownButton<String>(
                                  value: _selectedChoice,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedChoice = newValue!;
                                    });
                                    print('Selected: $newValue');
                                  },
                                  isExpanded: true,
                                  items: _choices.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.0),
                                child: TextField(
                                  onChanged: (String? Plate04) {
                                    setState(() {
                                      _Plate4 = Plate04!;
                                    });
                                    print('Plate03: $Plate04');
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: '4 Digit',
                                    errorText: null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                TextField(
                  onChanged: (String? Tel) {
                    setState(() {
                      _Tel = Tel!;
                      _isTelValid = Tel.isNotEmpty && Tel.length == 8;
                      _telTouched = true;
                    });
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8)
                  ],
                  decoration: InputDecoration(
                    labelText: 'TEL',
                    icon: Icon(Icons.phone),
                    errorText: _telTouched && !_isTelValid ? 
                      (_Tel!.isEmpty ? 'This field is required' : 'Must be 8 digits') : null,
                    errorStyle: TextStyle(color: Colors.red),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  onChanged: (String? MDP) {
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
                  onChanged: (String? MDP2) {
                    setState(() {
                      if (MDP2 == _MDP) {
                        _MDP2 = MDP2!;
                        PassCorrect = true;
                      } else {
                        PassCorrect = false;
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
                    Plate = _Plate4! + _selectedChoice! + _Plate3!;
                    print(Plate);

                    if (PassCorrect == true && 
                        _Plate3 != null && _Plate3!.isNotEmpty &&
                        _Plate4 != null && _Plate4!.isNotEmpty &&
                        _eemail != null && _eemail!.isNotEmpty &&
                        _uuserName != null && _uuserName!.isNotEmpty &&
                        _Tel != null && _Tel!.isNotEmpty &&
                        _MDP != null && _MDP!.isNotEmpty &&
                        _MDP2 != null && _MDP2!.isNotEmpty) {
                      print("D5all");
                      createUserwithEmailAndPassword().then((value) =>
                          {addUserDataToFirestore(), print("TLA3333")});
                      Auth().signOut();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Padding(
                            padding: EdgeInsets.only(
                                bottom: 10), // Add bottom margin here
                            child: Text(
                              "compte créée",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ), // Change font size here
                            ),
                          ),
                          backgroundColor: Color.fromARGB(
                              255, 0, 184, 3), // Change background color here
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Change shape here
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Padding(
                            padding: EdgeInsets.only(
                                bottom: 10), // Add bottom margin here
                            child: Text(
                              "All fields must be filled and correct",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ), // Change font size here
                            ),
                          ),
                          backgroundColor: const Color.fromARGB(
                              255, 207, 62, 52), // Change background color here
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(30), // Change shape here
                          ),
                        ),
                      );
                    }

                      
                    
                  },
                  child: Text('CONTINUE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
