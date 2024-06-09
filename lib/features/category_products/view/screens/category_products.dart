import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/widgets/app_text_field.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';
import 'package:momayaz/features/category_products/manager/categories_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key, required this.id, required this.category, required this.carCatId});

  final String id;
  final String category;
  final String carCatId;

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  final cubit = CategoriesProductCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getProducts(id: widget.id, carsCategoryId: widget.carCatId)..likes(id: widget.category, productId: widget.id),
      child: BlocBuilder<CategoriesProductCubit, CategoriesProductState>(
        builder: (context, state) {
          return SafeArea(
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
                              Icons.arrow_back_ios,
                              color: AppColors.offWhite,
                            )),
                        Text(
                          widget.carCatId,
                          style: TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),



                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return MainProductItem(
                          price: cubit.productModel[index].price,
                          title: cubit.productModel[index].title,
                          date: cubit.productModel[index].date.substring(0, 10),
                          city: cubit.productModel[index].location,
                          isFav:  cubit.productModel[index].isLiked ,
                          image: cubit.productModel[index].images[0],
                          onFavTap: () {
                            cubit.productModel[index].isLiked?
                            {
                              cubit.removeFav(catId: widget.id,
                                  productId: cubit.productModel[index].productId),
                              cubit.productModel[index].isLiked=false,

                            }
                                : {cubit.addFav(catId: widget.id, productId: cubit.productModel[index].productId),
                              cubit.productModel[index].isLiked=true,

                            };
                            setState(() {

                            });
                          },
                          productId: cubit.productModel[index].productId,
                          catId: widget.id,

                        );
                      },
                      itemCount: cubit.productModel.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
