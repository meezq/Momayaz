import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/features/register/view/screens/User_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key, required this.name});
  final String name;

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.sp),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            foregroundImage: NetworkImage(MyShared.getString(key: MySharedKeys.userImage)),
              child:Text(
                    widget.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(color: AppColors.offWhite, fontSize: 28.sp),

                  ),
          ),
          // if(MySharedKeys.userImage=="")
          //   {CircleAvatar(
          //     backgroundColor: AppColors.primary,
          //     radius: 25.sp,
          //     child:Text(
          //       name.substring(0, 1).toUpperCase(),
          //       style: TextStyle(color: AppColors.offWhite, fontSize: 28.sp),
          //     ),)
          //   };
          // else{ };
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        color: AppColors.offWhite,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  MyShared.getBoolean(key: MySharedKeys.isVerified)
                      ? const Icon(
                          Icons.verified_user_outlined,
                          color: AppColors.primary,
                        )
                      : const Icon(
                          Icons.error_outline,
                          color: AppColors.primary,
                        )
                ],
              ),
              InkWell(
                onTap: () {
                  push(context, UserScreen());
                },
                child: Text(
                  "View and edit profile",
                  style: TextStyle(
                    color: AppColors.offWhite,
                    fontSize: 17.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
