


import 'package:flutter/material.dart';
import 'package:flutter_application_1/details.dart';

class History extends StatelessWidget{
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Devices list :', style: TextStyle(fontSize: 20)),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.device_unknown, size: 50),
                title: Column(
                      children:const [
                        Text("Type",style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
                        SizedBox( width: 30),
                        Text("KM Depart" ,   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.blue)),
                        Text("KM ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        Text("KM arrivee", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.blue)),
                        Text("KM ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                      ],
                    ),//Text('modem ZTE orange'),
                shape: CircleBorder(eccentricity: 0.5),
                
              onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Detailss()),
            );
              },
              ),
              
            ),
            
          ],
        ),
        
      ),
    );
  }
}