import 'package:flutter/material.dart';
import '../classes/user.dart';
import '../subset/profilepage.dart';
import '../subset/homepage.dart';
import '../subset/subjectpage.dart';
import '../subset/tutorpage.dart';



class MainScreen extends StatefulWidget {
   final User user;
  const MainScreen({Key? key, required this.user}) : super(key: key);


  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
 return  const MaterialApp(
      home: MyStatefulWidget(),
    );
      }
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  final List<Widget> _widgetOptions = <Widget>[
   const Home(), 
    Profile(user:user,),
   const Subjects(),
   const Tutors(),
   
    const Text(
      'Sorry, no result found :(',
       style: TextStyle(fontWeight: FontWeight.bold, fontSize:24),
    ),
     const Text(
       'Sorry, no result found :(',
       style: TextStyle(fontWeight: FontWeight.bold, fontSize:24),
    ),
     const Text(
      'Sorry, no result found :(',
       style: TextStyle(fontWeight: FontWeight.bold, fontSize:24),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to My Tutors '),
         backgroundColor: Colors.green,

      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Subjects',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tutors',
            backgroundColor: Colors.amber,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: 'Subscribe',
            backgroundColor: Colors.orange,
          ),
             BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourite',
            backgroundColor: Colors.red,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }}
