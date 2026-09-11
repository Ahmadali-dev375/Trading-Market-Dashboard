// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:global_bottom_navigation_bar/global_bottom_navigation_bar.dart';
import 'Top.dart';
import 'home.dart';
import 'profile.dart';
import 'trend.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGlobalBottomNavigation(
      listOfChild: [Home(), Trending(), TopUp(), Profile()],
      listOfBottomNavigationItem: buildBottomNavigationItemList(),
    );
  }

  List<BottomNavigationItem> buildBottomNavigationItemList() => [
        BottomNavigationItem(
          activeIcon: Icon(
            Icons.home,
            color: Colors.white,
            size: 36,
          ),
          inActiveIcon: Icon(
            Icons.home,
            color: Colors.grey,
            size: 33,
          ),
          title: 'Explore',
          color: Color(0xFF211f40),
          vSync: this,
        ),
        BottomNavigationItem(
          activeIcon: Icon(
            Icons.fireplace_rounded,
            color: Colors.white,
            size: 36,
          ),
          inActiveIcon: Icon(
            Icons.fireplace_rounded,
            color: Colors.grey,
            size: 33,
          ),
          title: 'Trending',
          color: Color(0xFF211f40),
          vSync: this,
        ),
        BottomNavigationItem(
          activeIcon: Icon(
            Icons.add,
            color: Colors.white,
            size: 36,
          ),
          inActiveIcon: Icon(
            Icons.add,
            color: Colors.grey,
            size: 33,
          ),
          title: 'Top Up',
          color: Color(0xFF211f40),
          vSync: this,
        ),
        BottomNavigationItem(
          activeIcon: Icon(
            Icons.person_pin,
            color: Colors.white,
            size: 36,
          ),
          inActiveIcon: Icon(
            Icons.person_pin,
            color: Colors.grey,
            size: 33,
          ),
          title: 'Profile',
          color: Color(0xFF211f40),
          vSync: this,
        ),
      ];
}
