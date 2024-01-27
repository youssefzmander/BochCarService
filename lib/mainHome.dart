import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/history.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/informations.dart';
import 'package:flutter_application_1/localStorage.dart';
import 'package:flutter_application_1/profile.dart';
import 'package:flutter_application_1/signin.dart';

import 'package:flutter_application_1/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

LStorage lStorage = LStorage();
  UserData? storedData;

Future<void> fetchData() async {
  try {
  print('UserrrrrrrrrrIMATTTT: ${storedData?.Plate}');
  if (storedData?.Plate != null) {
    
    // Reference to the user's document in the 'users' collection
    
QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('FACT')
          .doc(storedData?.Plate)
          .collection('facture')
          .get();
print('UIMATTTT: ${storedData?.Plate}');
          if (querySnapshot.docs.isEmpty) {
        print('No documents found.');
      } else {
        print('Documents found:');
        // Convert Firestore document data to JSON
         List<Map<String, dynamic>> jsonDataList = [];
         List<Map<String, dynamic>>? jsonUniqueDataList = [];
        Map<String, dynamic> uniqueDataMap = {}; // Map to store unique data

       for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data();
          String libelleArticle = data['LIBELLEARTICLE'];

          // Convert Timestamp to DateTime
          //String dateFact = (data['Datefact'] as Timestamp).toDate().toIso8601String();
          String dateFact = (data['Datefact'] as Timestamp).toDate().toIso8601String();

          print(dateFact);
          print("dateFact");
          // Replace Timestamp with DateTime
          data['Datefact'] = dateFact;

          jsonDataList.add(data);
          print("data");
          print(data);
          if (uniqueDataMap.containsKey(libelleArticle)) {
            continue;
          }else{
            jsonUniqueDataList.add(data);
          uniqueDataMap[libelleArticle] = data;
          }
          
        }
        jsonUniqueDataList = uniqueDataMap.values.cast<Map<String, dynamic>>().toList();
        jsonUniqueDataList.sort((b, a) => a['Datefact'].compareTo(b['Datefact']));

        jsonDataList.sort((b, a) => a['Datefact'].compareTo(b['Datefact']));
        // Save JSON data to local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String jsonString = jsonEncode(jsonDataList);
        String jsonUniqueString = jsonEncode(jsonUniqueDataList);
        await prefs.setString('factureData', jsonString);
        await prefs.setString('factureUniqueData', jsonUniqueString);
        print('Data saved to local storage.');
        print('Data 3adeya$jsonString');
        print('Data Unique$jsonUniqueString');
      }
      print('5rjt');
    // Check if the document exists
    
  } else {
    print('User is not signed indaaaaata');
    ; // or throw an exception, depending on your error handling strategy
  }
  }catch (e) {
      print('Error retrieving data: $e');
    }
}

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
    loadData().then((value) => fetchData());
    
  }

  final List<Widget> _pages = [
    HomePage(),
    History(),
    Informations(),
    Profile(),
  ];

  final List<String> _pagesTitle = [
   
    "Home",
    "History",
    "Informations", 
    "Profile",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title:Text(_pagesTitle[_currentIndex]), backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Auth().signOut();
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignIn()),
            );
            },
          ),
          ],) ,
      
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
