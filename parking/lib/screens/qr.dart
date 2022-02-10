/* import 'package:parking/screens/add.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';





class Qr extends StatelessWidget {
  const Qr({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold( 
        body:Center(
       child: Column(
         children:  <Widget>[
QrImage(
  data: 'Uid:98v0BbYlDLPKGYwC1PHtjpIDy683 \n Hin:2021-12-16 19:30 \n Hout:2021-12-16 21:30',
  version: QrVersions.auto,
  size: 320,
  gapless: false,
),
ElevatedButton(
              onPressed: () {
              Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => AddUser("ez","ez",6)));
              },
              child: Text('Confirm'),
            ),
         ] 
       ),

      )),
    );
  }
}



 */