import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_app/upload/views/add_page.dart';
import 'package:form_app/home/views/home_page.dart';
import 'package:form_app/profile/views/profile_page.dart';


class NavigationTabs extends StatefulWidget {
   NavigationTabs({super.key});

  @override
  State<NavigationTabs> createState() => _NavigationTabsState();
  
}

class _NavigationTabsState extends State<NavigationTabs> {
  int _selectedIndex = 0;
  final _pages = [
    HomePage(),
    UploadPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        
        items: [
      BottomNavigationBarItem(
        icon: FaIcon(FontAwesomeIcons.house),
        label: ''
      ),
      BottomNavigationBarItem(
         icon:FaIcon(FontAwesomeIcons.penToSquare),
        label: ''
      ),
      BottomNavigationBarItem(
         icon:FaIcon(FontAwesomeIcons.user),  
        label: ''
      ),
     
    ],
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.black,
    selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
      )
    );
  }
}