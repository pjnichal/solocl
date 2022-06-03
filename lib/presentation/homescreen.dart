import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:solocl/presentation/mycity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: Image.asset("assets/logo.png"),
        title: const Text("Solocl", style: TextStyle(color: Colors.white)),
        elevation: 1,
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          MyCity(),
          Center(
            child: Text("Mall"),
          ),
          Center(
            child: Text("Community"),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 200),
              tabBackgroundColor: Colors.amber,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.maps_home_work_outlined,
                  text: 'MyCity',
                ),
                GButton(
                  icon: Icons.local_mall_outlined,
                  text: 'Mall',
                ),
                GButton(
                  icon: Icons.forum_outlined,
                  text: 'Coummnity',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  pageController.animateToPage(
                    index,
                    curve: Curves.ease,
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                  );
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
