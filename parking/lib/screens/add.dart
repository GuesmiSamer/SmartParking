// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking/models/user.dart';
import 'package:parking/screens/main_home.dart';
import 'package:parking/screens/profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Addres extends StatelessWidget {
  User user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser  = UserModel();
  final String Hin;
  final String Hout;
  final String id;
  final String mat;
  final int nbr;
  
  

  Addres(this.Hin, this.Hout, this.nbr,this.id,this.mat);


  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('Reservation');
 FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
       this.loggedInUser = UserModel.fromMap(value.data());
      
    });
  
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
           .doc(loggedInUser.uid)
    .set({
            'Hin': Hin, 
            'Hout': Hout, 
            'nbr': nbr ,
            'mat':mat
          })
          .then((value) => print(loggedInUser.uid))
          .catchError((error) => print("Failed to add res: $error"));
    }
      

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold( 
        backgroundColor: Colors.white,
        body:Center(
          
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
         children:  <Widget>[
           
        QrImage(
          data: "${id} \n ${Hin} \n  ${Hout} \n ",
          version: QrVersions.auto,
          size: 320,
          gapless: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            
           children:  <Widget>[  
             
             ElevatedButton(
             
                  onPressed:
                    _launchURL,
                  child: Text('Pay now'),
                   style: ElevatedButton.styleFrom(
                primary: Color(0xFF6C2A7C),
                 onPrimary: Colors.white, 
                ),
                ),
                 SizedBox(width: 20),
            ElevatedButton(
              
               onPressed:
                addUser,
              
              
              child: Text('Confirm'),
                style: ElevatedButton.styleFrom(
                primary: Color(0xFF6C2A7C),
                 onPrimary: Colors.white, 
                ),
            ),
             SizedBox(width: 20),
             ElevatedButton(
              onPressed: () {
              Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>HomeMain() ));
              },
              child: Text('Cancel'),
               style: ElevatedButton.styleFrom(
                primary: Color(0xFF6C2A7C),
                 onPrimary: Colors.white, 
                ),
            ),
           ]
        ),
           
         ] 
       ),

      )),
    );
    
    
    
  }
}

_launchURL() async {
  const url = 'https://sandbox.paymee.tn/panoramix/qrcodes/7adf2346b5439850dc56b349498d38f5?fbclid=IwAR03G0oF20yp4qFYtopXJuKEnayvd3BJMEgOg0M-HG6WfkRMvXwAGuxxoP4';
  if (!await launch(
      url,
      forceSafariVC: true,
      forceWebView: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }