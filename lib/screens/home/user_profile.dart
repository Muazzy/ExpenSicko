import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/constants/content.dart';
import 'package:expense_tracker_v2/services/auth_repository.dart';
import 'package:expense_tracker_v2/widgets/user_profile.dart/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = context.read<AuthRepository>().user;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(
            userImageHeroTag: userImageHeroTag,
            photoUrl: currentUser.photoURL,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/editprofile');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    FontAwesomeIcons.penToSquare,
                    size: 18,
                    color: AppColors.bodyTextColor,
                  ),
                  Text(
                    ' Edit',
                    style:
                        TextStyle(color: AppColors.bodyTextColor, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Personal Details',
                  style: TextStyle(
                    color: AppColors.darkPurple,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Name:',
                      style: TextStyle(
                        color: AppColors.bodyTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      currentUser.displayName ?? ' ',
                      style: const TextStyle(
                        color: AppColors.bodyTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          //TODO logout and generate report buttons here.
        ],
      ),
    );
  }
}
