import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/features/product_details/view/screens/product_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:momayaz/features/favourites/manager/add_favourite.dart';

class MainProductItem extends StatelessWidget {
  const MainProductItem({
    super.key,
    required this.price,
    required this.title,
    required this.date,
    required this.city,
    required this.isFav,
    required this.image,
    required this.onFavTap,
    required this.productId,
    required this.catId,
  });

  final String image, price, title, date, city;
  final bool isFav;
  final VoidCallback onFavTap;
  final String productId;
  final String catId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        push(
          context,
          ProductDetailsScreen(
            productId: productId,
            catId: catId,
          ),
        );
      },
      child: Container(
          margin: EdgeInsets.all(10.sp),
          width: 60.w,
          height: 19.h,
          decoration: BoxDecoration(
              border: Border.all(width: 2.4.sp, color: AppColors.offWhite),
              color: AppColors.second,
              borderRadius: BorderRadius.circular(10.sp)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImage(
                imageUrl: image,
                width: 50.w,
                height: 21.h,
                topRightRadius: 10.sp,
                topLeftRadius: 10.sp,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              price,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: AppColors.offWhite,
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: onFavTap,
                            child: Icon(
                              isFav == false
                                  ? Icons.favorite_outline
                                  : Icons.favorite,
                              color: AppColors.offWhite,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.offWhite,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        city,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.offWhite,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Text(
                        date,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.offWhite,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
