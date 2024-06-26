import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainCategoryItem extends StatelessWidget {
  const MainCategoryItem({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.sp),
      width: 19.w,
      height: 9.h,
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: AppImage(
        height: 1.5.h,
        width: 3.w,
        imageUrl: icon,
      ),
    );
  }
}
