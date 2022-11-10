import 'package:expense_tracker_v2/constants/colors.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String? photoUrl;
  const ProfileHeader({Key? key, required this.photoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.24,
      width: Size.infinite.width,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
              color: darkPink,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36)),
              color: darkPurple,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.2,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundColor: darkPink.withOpacity(0.1),
                radius: MediaQuery.of(context).size.width * 0.2 - 8,
                // backgroundImage: Image.network(
                //   'https://img.icons8.com/ios-filled/512/who.png',
                // ).image,
                backgroundImage: photoUrl != null
                    ? Image.network(
                        photoUrl ??
                            'https://img.icons8.com/ios-filled/512/who.png',
                      ).image
                    : Image.asset(
                        'assets/user_pp.png',
                      ).image,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: darkPink,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Colors.white,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.photo_camera_outlined,
                          size: 18,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
