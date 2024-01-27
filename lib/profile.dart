


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/localStorage.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  final List<String> _choices = ['TU', 'RS', 'FCR', 'DOUANE', 'ETAT', 'AUTRES'];
  late String? _selectedChoice= "DOUANE";
  LStorage lStorage = LStorage();
  UserData? storedData;
  final _auth = FirebaseAuth.instance;
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _errorMessage = '';

  Map<String, dynamic>? mapData;
  Future<void> loadData() async {
     mapData = await lStorage.getStoredData('userData');
     if (mapData != null) {
      storedData = UserMapper.mapToUserData(mapData!);
      print('Stored Map Data: $storedData');
      // You can use storedData as needed in your widget
      setState(() {}); // Trigger a rebuild to update the UI
    }
    print('Stored Map Data: $storedData');
    // You can use storedData as needed in your widget
  }
@override
  void initState() {
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('settings and privacy', style: TextStyle(fontSize: 20)),
              leading: Icon(Icons.settings),
            ),
            ListTile(
              title: Text('personal account information', style: TextStyle(fontSize: 20)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  icon: Icon(Icons.person),
                  hintText: storedData?.UserName ,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  icon: Icon(Icons.email),
                  hintText: storedData?.Email,
                  
                ),
              ),
              SizedBox(height: 20),
              Text(
                    'Plate Number',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  
             
   // Adjust the left padding as needed
   Row(
   // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment as needed
    children: [
      Container(
        width: 70, // Set width
  height: 60,
        child: TextField(
          enabled: _selectedChoice == 'TU',
          decoration: InputDecoration(
            labelText: '3 Degit',
            hintText: storedData?.Plate3,
            //icon: Icon(Icons.numbers),
          ),
        ),
      ),
      Container(
        width: 100, // Set width
  height: 50,
        
    
     // Set the desired fixed width
        child: DropdownButton<String>(
          value: _selectedChoice,
          onChanged: (String? newValue) {
            setState(() {
              _selectedChoice = newValue!;
            });
            
            print('Selected: $storedData');
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
          decoration: InputDecoration(
            labelText: '4 Degit',
            hintText: storedData?.Plate4,
            //icon: Icon(Icons.numbers),
          ),
        ),
      ),
    ],
  ),

              
              TextField(
                decoration: InputDecoration(
                  labelText: 'TEL',
                  icon: Icon(Icons.phone),
                  hintText: storedData?.Tel,
                ),
              ),
              SizedBox(height: 20),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                child: Text('Update'),
              ),
            ),
            ListTile(
              title: Text('password and security', style: TextStyle(fontSize: 20)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'old password',
                    ),
                     controller: _oldPasswordController,
                     obscureText: true,

                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'new password',
                    ),
                    controller: _newPasswordController,
                    obscureText: true,
                  ),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'password confirmation',
                    ),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () async {
                String oldPassword = _oldPasswordController.text;
                String newPassword = _newPasswordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (newPassword != confirmPassword) {
                  setState(() {
                    _errorMessage = 'Passwords do not match';
                  });
                  return;
                }

                try {
                  // Reauthenticate the user with their old password
                  AuthCredential credential = EmailAuthProvider.credential(
                      email: _auth.currentUser!.email!,
                      password: oldPassword);
                  await _auth.currentUser!.reauthenticateWithCredential(credential);

                  // Update the user's password
                  await _auth.currentUser!.updatePassword(newPassword);

                  // Password updated successfully
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Password changed successfully'),
                  ));
                } catch (error) {
                  setState(() {
                    _errorMessage = error.toString();
                  });
                }
              },
                child: Text('Update'),
              ),
            ),
            
         
            
            
          ],
        ),
      ),
    );
  }
}
