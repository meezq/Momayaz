import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/widgets/app_image.dart';
import 'package:momayaz/features/cars/managet/cars_category_cubit.dart';
import 'package:momayaz/features/category_products/view/screens/category_products.dart';
import 'package:momayaz/features/sell_Product/category.dart';
import 'package:momayaz/features/sell_Product/view/screens/sold_product_details.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({
    super.key,
    this.category,
    this.isGettingData = true,
    this.id = "",
    this.productCategory = "",
  });

  final Category? category;
  final bool isGettingData;
  final String id, productCategory;

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  final cubit = CarsCategoryCubit();

  @override
  void initState() {
    cubit.getCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.second,
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            leading: IconButton(
              onPressed: () {
                pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.offWhite,
              ),
            ),
            title: Text(
              "Cars",
              style: TextStyle(
                color: AppColors.offWhite,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(child: BlocBuilder<CarsCategoryCubit, CarsCategoryState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: cubit.cars.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: widget.isGettingData
                            ? () {
                                push(
                                  context,
                                  CategoryProducts(
                                    id: widget.id,
                                    category: widget.productCategory,
                                    carCatId: cubit.cars[index].id,
                                  ),
                                );
                              }
                            : () {
                                push(
                                    context,
                                    SoldProductDetailsScreen(
                                        category: Category(
                                            categoryImage:
                                                widget.category!.categoryImage,
                                            categoryName:
                                                widget.category!.categoryName,
                                            categoryId:
                                                widget.category!.categoryId,
                                            carCategoryId: cubit.cars[index].id,
                                            carCategoryImage:
                                                cubit.cars[index].image,
                                            carCategoryName:
                                                cubit.cars[index].name)));
                              },
                        child: Container(
                          margin: EdgeInsets.all(12.sp),
                          padding: EdgeInsets.all(12.sp),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10.sp),
                                width: 19.w,
                                height: 9.h,
                                padding: EdgeInsets.all(14.sp),
                                decoration: BoxDecoration(
                                  color: AppColors.offWhite,
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: AppImage(
                                  imageUrl: cubit.cars[index].image,
                                  width: 12.w,
                                  height: 6.h,
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                cubit.cars[index].name,
                                style: TextStyle(
                                  color: AppColors.offWhite,
                                  fontSize: 18.sp,
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppColors.offWhite,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
