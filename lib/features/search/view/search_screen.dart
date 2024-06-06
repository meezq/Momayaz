import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/core/widgets/app_text_field.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';
import 'package:momayaz/features/search/manager/search_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final cubit = SearchCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: SafeArea(
        child: Scaffold(

          backgroundColor: AppColors.second,
          body: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    children: [
                      Row(children: [IconButton(
                        onPressed: () {
                          pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.offWhite,
                        ),
                      ),
                        Text(
                          "Search",
                          style: TextStyle(
                              color: AppColors.offWhite,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],),

                      AppTextField(hint: "Search For Product",

                          onFieldSubmitted: (value) {

                        safePrint(cubit.searchC.text);
                            cubit.getProductsSearch(value: cubit.searchC.text);
                            setState(() {

                            });

                          },
                          keyboardType: TextInputType.text,
                          icon: Icons.search,
                          controller: cubit.searchC,
                          isPassword: false,
                          textInputAction: TextInputAction.search,
                          title: "Search"),

                    ],

                  ),
                ),
                SizedBox(height: 2.h,),
                // Row(
                //   children: [
                //     Text(
                //       "${cubit.productModel.length} Results found",
                //       style: TextStyle(
                //           color: AppColors.offWhite,
                //           fontSize: 18.sp,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),
                Expanded(

                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: cubit.productModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MainProductItem(
                            price: cubit.productModel[index].price,
                            title: cubit.productModel[index].title,
                            date: cubit.productModel[index].date.substring(0, 10),
                            city: cubit.productModel[index].location,
                            isFav:  cubit.productModel[index].isLiked ,
                            image: cubit.productModel[index].images[0],
                            onFavTap:
                                () {
                              cubit.productModel[index].isLiked?
                              {
                                cubit.removeFav(catId: cubit.productModel[index].categoryId,
                                    productId: cubit.productModel[index].productId),
                                cubit.productModel[index].isLiked=false,

                              }
                                  : {cubit.addFav(catId: cubit.productModel[index].categoryId, productId: cubit.productModel[index].productId),
                                cubit.productModel[index].isLiked=true,

                              };
                              setState(() {

                              });
                            },
                            productId: cubit.productModel[index].productId,
                            catId: cubit.productModel[index].categoryId,

                          );
                        },

                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
