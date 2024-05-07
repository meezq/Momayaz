import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/widgets/main_category_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem(
      {super.key,
      required this.icon,
      required this.title,
       this.onTap = null});

  final String icon;
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          children: [
            MainCategoryItem(
              icon: icon,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.offWhite,
                  fontSize: 20.sp,
                  //fontWeight: FontWeight.bold
                ),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.offWhite,
            )
          ],
        ),
      ),
    );
  }
}
