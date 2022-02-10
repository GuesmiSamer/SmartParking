import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:parking/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking/screens/edit_profile.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  int? currentTabIndex;
  String image="https://firebasestorage.googleapis.com/v0/b/parking-1aec9.appspot.com/o/avatar-1577909_960_720.png?alt=media&token=21232087-f24b-42e8-9fc4-a7c6afd789d3";
  

  @override
  void initState() {
    super.initState();
     currentTabIndex = 0;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
   void setCurrentIndex(int val) {
      setState(() {
        currentTabIndex = val;
      });
    }
 Future getImage() async {
    final pickedimage = await loggedInUser.profileImage;

    setState(() {
      if (pickedimage==null){
        image="https://firebasestorage.googleapis.com/v0/b/parking-1aec9.appspot.com/o/avatar-1577909_960_720.png?alt=media&token=21232087-f24b-42e8-9fc4-a7c6afd789d3";
      }
      else {
        image=pickedimage;
      }
      
    });
    return image;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            
            image: AssetImage('assets/background2.jpg'),
            fit: BoxFit.cover,
          
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.network(image, fit: BoxFit.contain),
              ),
              Text(
                
                "Welcome Back",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20,color: Colors.orange)),
              Text("${loggedInUser.email}",
                 style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20,color: Colors.black)),
              SizedBox(
                height: 15,
              ),
              
      
     
      
       ElevatedButton(
           style: ElevatedButton.styleFrom(
                primary: Color(0xFF6C2A7C),
                 onPrimary: Colors.white, 
                ),
          
          onPressed: () {
            
             Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => EditProfile()));
          },
          child: Text(
            "Edit Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )
          
          ),
              
              ElevatedButton(

           style: ElevatedButton.styleFrom(
                primary: Color(0xFF6C2A7C),
                 onPrimary: Colors.white, 
                ),
         
          onPressed: () {
            
             logout(context);
          },
          child: Text(
            "Logout",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )
          
          ),
              
          
    

              
            ],
          ),
        ),
      ),
     
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}