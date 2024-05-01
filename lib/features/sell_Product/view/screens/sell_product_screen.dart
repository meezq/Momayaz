import 'package:momayaz/features/cars/view/cars_screen.dart';
import 'package:momayaz/features/categories/manager/categories_cubit.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/widgets/categories_item.dart';
import 'package:momayaz/features/sell_Product/category.dart';
import 'package:momayaz/features/sell_Product/view/screens/sold_product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SellProductScreen extends StatelessWidget {
  SellProductScreen({super.key});

  final cubit = CategoriesCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getCat(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          toolbarHeight: 0,
        ),
        backgroundColor: AppColors.second,
        body: Column(
          children: [
            Container(
              color: Colors.grey[900],
              padding: EdgeInsets.all(13.sp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.offWhite,
                      )),
                  Text(
                    "What are you offering?",
                    style: TextStyle(
                        color: AppColors.offWhite,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is GetCatLoading) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CategoriesItem(
                          icon: cubit.cats[index].image,
                          title: cubit.cats[index].category,
                          onTap: () {
                            if (cubit.cats[index].category == "3" ||
                                cubit.cats[index].category == "4" ||
                                cubit.cats[index].category == "9") {
                              push(
                                  context,
                                  SoldProductDetailsScreen(
                                      category: Category(
                                          categoryImage:  cubit.cats[index].image,
                                          categoryName:  cubit.cats[index].category,
                                          categoryId:  cubit.cats[index].id,
                                      )));
                            } else {
                              push(context, CarsScreen(
                                isGettingData: false,
                                category:Category(
                                  categoryImage:  cubit.cats[index].image,
                                  categoryName:  cubit.cats[index].category,
                                  categoryId:  cubit.cats[index].id,
                                ) ,

                              ));
                            }
                          },
                        );
                      },
                      itemCount: cubit.cats.length,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
