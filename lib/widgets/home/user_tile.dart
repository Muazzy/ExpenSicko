import 'package:expense_tracker_v2/res/colors.dart';
import 'package:expense_tracker_v2/constants/content.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.onTap,
    required this.userImage,
    required this.userName,
    required this.onProfileImageTap,
    required this.userImageHeroTag,
  }) : super(key: key);
  final void Function() onTap;
  final Widget userImage;
  final String userName;
  final String userImageHeroTag;
  final void Function() onProfileImageTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.075),
      child: ListTile(
        isThreeLine: false,
        // contentPadding:
        // EdgeInsets.zero, //for removing the default padding
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        minVerticalPadding: 0,
        // onTap: onTap,
        // tileColor: Colors.amber.shade50,
        dense: false,
        trailing: IconButton(
          tooltip: 'Logout',
          onPressed: onTap,
          icon: const Icon(
            Icons.logout,
            color: AppColors.darkPink,
          ),
        ),
        leading: Hero(
          tag: userImageHeroTag,
          child: Material(
            type: MaterialType.transparency,
            child: GestureDetector(
              onTap: onProfileImageTap,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: MediaQuery.of(context).size.width * 0.11,
                height: MediaQuery.of(context).size.width * 0.11,
                decoration: BoxDecoration(
                  color: AppColors.darkPink.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: userImage,
              ),
            ),
          ),
        ),
        title: Text(
          'Welcome back,',
          style: TextStyle(
            color: AppColors.bodyTextColor.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
        subtitle: Text(
          userName, //user name will go here.
          style: const TextStyle(
            color: AppColors.bodyTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
