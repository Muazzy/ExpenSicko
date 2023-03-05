import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/res/content.dart';
import 'package:expense_tracker_v2/res/image_paths.dart';
import 'package:expense_tracker_v2/model/onboard_page_model.dart';
import 'package:expense_tracker_v2/widgets/onboard/dot_indicators.dart';
import 'package:expense_tracker_v2/widgets/signin_signup/signin_and_get_started_btn.dart';
import 'package:flutter/material.dart';

import '../widgets/onboard/onboard_page.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  late PageController _pageController;

  List<OnBoardPageModel> pages = <OnBoardPageModel>[
    OnBoardPageModel(
        image: AppImagePaths.obImg1, heading: obHeading1, bodyText: obBody1),
    OnBoardPageModel(
        image: AppImagePaths.obImg2, heading: obHeading2, bodyText: obBody2),
  ];

  int currentPage = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  controller: _pageController,
                  itemCount: pages.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return OnboardPage(
                      image: pages[index].image,
                      heading: pages[index].heading,
                      bodyText: pages[index].bodyText,
                      textColor: AppColors.bodyTextColor,
                    );
                  },
                ),
              ),

              //indicator dot rows
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => DotIndicator(
                      activeColor: AppColors.darkPurple,
                      notActiveColor: AppColors.accentColor,
                      index: index,
                      currentIndex: currentPage,
                    ),
                  ),
                ),
              ),

              //circle button
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.085,
                ),
                child: SignInAndGetStartedButton(
                  buttonBgColor: AppColors.darkPurple,
                  buttonFontColor: AppColors.white,
                  buttonText: 'Get Started',
                  fullWidth: true,
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/signIn');
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
