import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/widgets/app_text_field.dart';
import 'package:momayaz/core/widgets/drop_down.dart';
import 'package:momayaz/features/sell_Product/manager/sell_product__cubit.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SparePartSellItem extends StatefulWidget {
  const SparePartSellItem({
    super.key,
  });

  @override
  State<SparePartSellItem> createState() => _SparePartSellItemState();
}

class _SparePartSellItemState extends State<SparePartSellItem> {
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
          DropDownTextFormField(
            validators: (value) {
              if (value!.isEmpty) {
                return "this field is required";
              }
              return null;
            },
            hint: 'Type',
            controller: context.read<SellProductCubit>().partType,
            enabled: false,
            count: 5,
            dropDownList: const [
              DropDownValueModel(
                name: "Car Body & Exterior",
                value: "Car Body & Exterior",
              ),
              DropDownValueModel(
                name: "Car Engine & Propulsion",
                value: "Car Engine & Propulsion",
              ),
              DropDownValueModel(
                name: "Car Handling & Wheels",
                value: "Car Handling & Wheels",
              ),
              DropDownValueModel(
                name: "Car Interior & Electronics",
                value: "Car Interior & Electronics",
              ),
              DropDownValueModel(
                name: "Car Technology & Connectivity",
                value: "Car Technology & Connectivity",
              ),
              DropDownValueModel(
                name: "Car Security & Safety",
                value: "Car Security & Safety",
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            "Dimensions *",
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
            keyboardType: TextInputType.number,
            icon: Icons.space_dashboard_outlined,
            controller: context.read<SellProductCubit>().dimensionsEditingController,
            isPassword: false,
            textInputAction: TextInputAction.next,
            title: "Dimensions",
          ),
        ],
      ),
    );
  }
}
