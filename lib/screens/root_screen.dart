import 'package:expense_tracker_v2/services/data_repository.dart';
import 'package:expense_tracker_v2/screens/home_screen.dart';
import 'package:expense_tracker_v2/screens/statistics_screen.dart';
import 'package:expense_tracker_v2/widgets/custom_fab.dart';
import 'package:expense_tracker_v2/widgets/custom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  List screens = [
    const HomeScreen(),
    const StatScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<DataRepositroy>(context).getCurrentIndex;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          Provider.of<DataRepositroy>(context, listen: false).currentIndex =
              index;
        },
      ),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.width * 0.2, //0.17
        width: MediaQuery.of(context).size.width * 0.2,
        child: CustomFAB(
          onPressed: () {
            Navigator.pushNamed(context, '/addTransaction');
          },
        ),
      ),
      body: screens[currentIndex],
    );
  }
}

//for making the cool looking icon color
