import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/widgets/main_category_item.dart';
import 'package:momayaz/features/cars/view/cars_screen.dart';
import 'package:momayaz/features/categories/view/screens/categories_screen.dart';
import 'package:momayaz/features/category_products/view/screens/category_products.dart';
import 'package:momayaz/features/home/manager/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeCategoriesWidgets extends StatelessWidget {
  const HomeCategoriesWidgets({
    super.key,
    required this.cats,
  });

  final List cats;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15.sp),
          child: Row(
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  color: AppColors.offWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  push(
                    context,
                    CategoriesScreen(
                      cats: cats, carCategoryId: '',
                    ),
                  );
                },
                child: Text(
                  "see all",
                  style: TextStyle(
                    color: AppColors.offWhite,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.offWhite,
                size: 14.sp,
              )
            ],
          ),
        ),
        SizedBox(
          height: 13.h,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                    push(context, CarsScreen(id:  cats[index].id,
                    productCategory:  cats[index].category,
                    ));
                    },
                    child: Column(
                      children: [
                        MainCategoryItem(icon: cats[index].image),
                        Text(
                          cats[index].category,
                          style: TextStyle(
                            color: AppColors.offWhite,
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: cats.length,
              );
            },
          ),
        )
      ],
    );
  }
}
