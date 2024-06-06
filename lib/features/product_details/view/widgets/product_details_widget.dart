import 'package:momayaz/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget(
      {super.key, required this.type, required this.description});

  final String type, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(15.sp),
          width: double.infinity,
          color: Colors.grey[850],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Details",
                style: TextStyle(
                    color: AppColors.offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Type:",
                        style: TextStyle(
                          color: AppColors.offWhite,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 9.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: TextStyle(
                          color: AppColors.offWhite,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: TextStyle(
                    color: AppColors.offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                description,
                style: TextStyle(
                  color: AppColors.offWhite,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20.sp),
          padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 13.0),
          decoration : BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14)
          ),
          child: Center(
            child: Text(
              "BOOK NOW",
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight : FontWeight.bold
              ),

            ),
          ),
        ),
      ],
    );
  }
}
