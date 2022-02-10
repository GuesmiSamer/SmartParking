import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/user.dart';
import 'package:parking/screens/qr.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:parking/models/uitls.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

import 'add.dart';



class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
    CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
 TimeOfDay _time = TimeOfDay.now();
 final dateFormat = DateFormat('yyyy-MM-dd');
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser  = UserModel();
 
 int _currentValue = 1;
 
void initState() {
    super.initState();
    
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
               Text(
              'Book your parking place ',style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30,color: Colors.white),
            ),
              Container(
                color: Colors.white,
                child: TableCalendar(
                
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
                _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
              ),
     
            ElevatedButton(
              onPressed: _selectTime,
              child: Text('SELECT START TIME'),
            ),
            SizedBox(height: 8),
            Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected time: ',style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20,color: Colors.purple),
            ),Text(
              '${_time.format(context)}',style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20)
            ),
          ],
            ),
            
             Theme(
               data: theme.copyWith(
        accentColor: Colors.black,// highlted color
          textTheme: theme.textTheme.copyWith(
            headline5: theme.textTheme.headline5!.copyWith(color: Colors.orange), //other highlighted style
            bodyText2: theme.textTheme.headline5!.copyWith(color: Colors.white), //not highlighted styles
      )),
               child: NumberPicker(
          value: _currentValue,
          minValue: 1,
          maxValue: 24,
          
          onChanged: (value) => setState(() => _currentValue = value),
        ),
             ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Number of hours: ',style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20,color: Colors.purple),
            ),
            Text(
              '$_currentValue',style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20)
            ),
          ],
            ),
            ElevatedButton(
              onPressed: () {
              Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Addres( dateFormat.format(_selectedDay)+"||"+_time.format(context),_time.addHour(_currentValue).format(context),_currentValue,loggedInUser.uid,loggedInUser.mat)));
              },
              child: Text('Book now'),
            ),

          
      ]
        ),
        
        
        ),
        
        
    );
  }
}
extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addHour(int hour) {
    return this.replacing(hour: this.hour + hour, minute: this.minute);
  }
}