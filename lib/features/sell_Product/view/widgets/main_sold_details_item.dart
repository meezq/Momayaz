import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/widgets/app_text_field.dart';
import 'package:momayaz/core/widgets/drop_down.dart';
import 'package:momayaz/core/widgets/main_category_item.dart';
import 'package:momayaz/features/cities/manager/cities_cubit.dart';
import 'package:momayaz/features/sell_Product/manager/sell_product__cubit.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainSoldDetailsItem extends StatelessWidget {
  MainSoldDetailsItem(
      {super.key,
      required this.image,
      required this.id,
      required this.category, required this.sCat, required this.sImage, required this.sId});

  final String image, id, category,sCat,sImage,sId;
  final cubit = CitiesCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getCities(),
      child: BlocBuilder<CitiesCubit, CitiesState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category *",
                          style: TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            MainCategoryItem(
                              icon: image,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              category,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sub Category *",
                          style: TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            MainCategoryItem(
                              icon: sImage,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              sCat,
                              style: TextStyle(
                                  color: Colors.grey[800],
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.all(15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "City *",
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
                      hint: 'Cairo',
                      controller: context.read<SellProductCubit>().location,
                      enabled: true,
                      count: cubit.cities.length,
                      dropDownList: List.generate(cubit.cities.length, (index) {
                        return DropDownValueModel(
                          name: cubit.cities[index].city,
                          value: cubit.cities[index].city,
                        );
                      }),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      "Title *",
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
                        icon: Icons.title,
                        controller: context
                            .read<SellProductCubit>()
                            .titleEditingController,
                        isPassword: false,
                        textInputAction: TextInputAction.next,
                        title: "add title for your product"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price *",
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
                        hint: "1,000,000 EGP",
                        keyboardType: TextInputType.number,
                        icon: Icons.attach_money_sharp,
                        controller: context
                            .read<SellProductCubit>()
                            .priceEditingController,
                        isPassword: false,
                        textInputAction: TextInputAction.next,
                        title: "add your price"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description *",
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
                        hint: "... .... ... ... ",
                        keyboardType: TextInputType.text,
                        icon: Icons.description_outlined,
                        controller: context
                            .read<SellProductCubit>()
                            .descriptionEditingController,
                        isPassword: false,
                        textInputAction: TextInputAction.next,
                        title: "add description for your product"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
