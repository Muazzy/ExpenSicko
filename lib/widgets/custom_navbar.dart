import 'package:expense_tracker_v2/res/colors.dart';
import 'package:flutter/material.dart';

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
        canvasColor: AppColors.white,
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
          unselectedItemColor: AppColors.bodyTextColor.withOpacity(0.3),
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
          AppColors.darkPurple,
          AppColors.darkPurple.withOpacity(0.6),
          AppColors.darkPurple.withOpacity(0.1),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
