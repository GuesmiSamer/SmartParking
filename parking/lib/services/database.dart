/* // @dart=2.9
import 'dart:html';

import 'package:parking/models/reservation.dart ';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parking/screens/reservations.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference ResCollection = FirebaseFirestore.instance.collection('Reservation');

  Future<void> updateUserData(DateTime Hin,DateTime Hout;) async {
    return await ResCollection.doc(uid).set({
      'Hin': Hin,
      'Hout': Hout,
     
    });
  }

  // list from snapshot
  List<Reservation> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      //print(doc.data);
      return Reservation(
        Hin: doc.data(),
        Hout: doc.data['Hout'] ?? 0,
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

} */