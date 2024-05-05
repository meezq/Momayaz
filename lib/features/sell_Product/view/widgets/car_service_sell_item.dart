import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/widgets/app_text_field.dart';
import 'package:momayaz/features/sell_Product/manager/sell_product__cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarServiceSellItem extends StatelessWidget {
  const CarServiceSellItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Type *",
            style: TextStyle(
                color: AppColors.offWhite,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2.h,
          ),
          AppTextField(
            validators: (value) {
              if (value!.isEmpty) {
                return "this field is required";
              }
              return null;
            },
            hint: "..........",
            keyboardType: TextInputType.text,
            icon: Icons.merge_type,
            controller: context
                .read<SellProductCubit>()
                .carServiceTypeEditingController,
            isPassword: false,
            textInputAction: TextInputAction.next,
            title: "Type",
          ),
        ],
      ),
    );
  }
}
