
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/user.dart';
import 'package:parking/screens/home_callendar.dart';
import 'package:parking/screens/main_home.dart';
class Reservations extends StatefulWidget {
  @override
  
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();
  
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

 
   bool snap=false;
  void initState() {
    super.initState();
   
    FirebaseFirestore.instance
    .collection('Reservation')
    .doc(user!.uid)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        snap=true;
        setState(() {});
      } 
      
    });
    
      
      
    }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: 
        Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'),
            fit: BoxFit.cover,
          
          ),
        ),
      child:getWidget(),
        ),
    );
  }


  
  Widget  getWidget() {



if (snap==true) {
  
 return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SimpleFoldingCell.create(
        key: _foldingCellKey,
        frontWidget: _buildFrontWidget(),
        innerWidget: _buildInnerWidget(),
        cellSize: Size(MediaQuery.of(context).size.width, 140),
        padding: EdgeInsets.all(15),
        animationDuration: Duration(milliseconds: 300),
        borderRadius: 10,
        onOpen: () => print('cell opez'),
        onClose: () => print('cell cloz'),
      ),
            ]
      );

}
else { return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Text(
              'No bookings yet ',style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, fontSize: 30,color: Colors.white),
            ),
             ElevatedButton(
              onPressed: () {
              Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeMain()));
              },
              child: Text('Book now'),
            ),
            ]
      );}
}
  Widget _buildFrontWidget() {
    return GestureDetector(
      onTap: () => _foldingCellKey.currentState?.toggleFold(),
      child:Container(
      color: Colors.white,
      alignment: Alignment.center,
      
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              
              "Reservation Time: \n2021-12-22 || 10:30",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
              ),
             
            ),
          
         
        ],
      ),
      ),
    );
  }

  Widget _buildInnerWidget() {
    return GestureDetector(
    onTap: () => _foldingCellKey.currentState?.toggleFold(),
    child: Container(
      color: Color(0xFFecf2f9),
      padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            
            child: Text(
              data(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
            ),
          ),
           
            Positioned(
            right: 180,
            bottom: 60,
            child: 
            
            GestureDetector(
              onDoubleTap: delete,
              
              
              child:
                new Icon(
                  
                              Icons.delete,
                               
                    ),
              
            ),
                 
          
          ),
          
        ],
      ),
    ),
    );
  }
} 

 CollectionReference res = FirebaseFirestore.instance.collection('Reservation');
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();
Future<void> delete() {
  
  return res
    .doc(user!.uid)
    .delete()
    .then((value) => print("res Deleted"))
    .catchError((error) => print("Failed to delete res: $error"));
    
}
 String data() {
    
    String data='2021-12-22 \n In:10:30 \n Out:14:30';
   FirebaseFirestore.instance
    .collection('Reservation')
    .doc(user!.uid)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        data=documentSnapshot.data().toString();
      } else {
        print('Document does not exist on the database');
      }
    });
    return data;
  }