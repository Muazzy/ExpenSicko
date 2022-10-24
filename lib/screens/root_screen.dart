import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.width * 0.17,
        width: MediaQuery.of(context).size.width * 0.17,
        child: CustomFAB(onPressed: () {}),
      ),
      //implement this later
      // body: ,
    );
  }
}

class CustomFAB extends StatelessWidget {
  final void Function() onPressed;
  const CustomFAB({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: darkPurple,
      clipBehavior: Clip.hardEdge,
      // isExtended: t,
      onPressed: onPressed,
      child: Icon(
        Icons.add_rounded,
        color: white,
        size: MediaQuery.of(context).size.width * 0.1,
      ),
    );
  }
}

//for making the cool looking icon color
class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          darkPurple,
          darkPurple.withOpacity(0.6),
          darkPurple.withOpacity(0.1),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  const CustomBottomNavBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: white,
      ),
      child: BottomAppBar(
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          iconSize: MediaQuery.of(context).size.width * 0.06,
          onTap: onTap,
          currentIndex: currentIndex,
          unselectedItemColor: bodyTextColor.withOpacity(0.3),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: '',
              icon: Icon(
                Icons.home_filled,
              ),
              activeIcon: RadiantGradientMask(
                child: Icon(
                  Icons.home_filled,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: RadiantGradientMask(
                child: Icon(
                  Icons.pie_chart_outline,
                ),
              ),
              icon: Icon(
                Icons.pie_chart_outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
