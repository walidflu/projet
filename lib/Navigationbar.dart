import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'BankAccount.dart';
import 'Dashboard.dart';
import 'Items_page.dart';
import 'Profile_Page.dart';
import 'Purachase_Page.dart';

import 'Reports.dart';
import 'Sales_page.dart';
import 'Settings_Page.dart';

class NavigationBAR extends StatefulWidget {
  @override
  _NavigationBARState createState() => _NavigationBARState();
}

class _NavigationBARState extends State<NavigationBAR> {
  int _selectedIndex = 0;
  bool _isExtended = false;
  final List<Map<String, dynamic>> _screens = [
    {'screen': Dashboard(), 'title': 'Dashboard', 'icon': Icons.dashboard},
    {'screen': Items(), 'title': 'Items', 'icon': Icons.list},
    {'screen': Sales(), 'title': 'Sales', 'icon': Icons.attach_money},
    {'screen': Purchases(), 'title': 'Purchases', 'icon': Icons.shopping_cart},
    {
      'screen': BankAccount(),
      'title': 'Bank Account',
      'icon': Icons.account_balance
    },
    {'screen': Reports(), 'title': 'Reports', 'icon': Icons.insert_chart},
    {'screen': Settings(), 'title': 'Settings', 'icon': Icons.settings},
    {'screen': Profile(), 'title': 'Profile', 'icon': Icons.person},
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
        title: Text(
          _screens[_selectedIndex]['title'],
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Use side-by-side layout for larger screens
            return Row(
              children: [
                NavigationRail(
                  selectedIconTheme: IconThemeData(color: Colors.deepPurple.shade900),
                  backgroundColor: Colors.deepPurple,
                  labelType: NavigationRailLabelType.selected,
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  extended: _isExtended,
                  destinations: _screens
                      .map(
                        (screen) => NavigationRailDestination(
                      icon: Icon(
                        screen['icon'],
                        color: Colors.white,
                      ),
                      label: Text(screen['title'], style: TextStyle(color: Colors.white)),
                    ),
                  )
                      .toList(),
                ),
                VerticalDivider(thickness: 1, width: 1),
                Expanded(child: _screens[_selectedIndex]['screen']),
              ],
            );
          } else {
            // Use bottom navigation bar for smaller screens
            return Column(
              children: [
                Expanded(child: _screens[_selectedIndex]['screen']),
                BottomNavigationBar(
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  selectedItemColor: Colors.deepPurple,
                  items: _screens
                      .map(
                        (screen) => BottomNavigationBarItem(
                      icon: Icon(screen['icon']),
                      label: screen['title'],
                    ),
                  )
                      .toList(),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
