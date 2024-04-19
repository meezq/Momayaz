import 'package:momayaz/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/features/my_ads/manager/my_ads_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  final cubit = MyAdsCubit();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(13.sp),
          child: Text(
            "My Ads",
            style: TextStyle(
                color: AppColors.offWhite,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return cubit.products[index];
            },
            itemCount: cubit.products.length,
          ),
        ),
      ],
    );
  }
}
