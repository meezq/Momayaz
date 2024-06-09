import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/widgets/app_image.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/features/category_products/view/screens/category_products.dart';
import 'package:momayaz/features/favourites/manager/add_favourite.dart';
import 'package:momayaz/features/home/manager/home_cubit.dart';
import 'package:momayaz/features/product_details/view/screens/product_details_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductsItem extends StatefulWidget {
  const ProductsItem({super.key, required this.title});

  final String title;

  @override
  State<ProductsItem> createState() => _ProductsItemState();
}

//bool isliked = FirebaseFirestore.instance.;

class _ProductsItemState extends State<ProductsItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15.sp),
          child: Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: AppColors.offWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  },
                child: Text(
                  "",
                  style: TextStyle(color: AppColors.offWhite, fontSize: 15.sp,),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              // Icon(
              //   Icons.arrow_forward_ios_rounded,
              //   color: AppColors.offWhite,
              //   size: 14.sp,
              // )
            ],
          ),
        ),
        Container(
          color: AppColors.second,
          height: 40.h,
          child: ListView.builder(
            itemCount: widget.title == 'Cars For Sale'
                ? BlocProvider.of<HomeCubit>(context).sell.length
                : BlocProvider.of<HomeCubit>(context).rent.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              MainProductItem product = widget.title == 'Cars For Sale'
                  ? MainProductItem(
                      price:
                          BlocProvider.of<HomeCubit>(context).sell[index].price,
                      title:
                          BlocProvider.of<HomeCubit>(context).sell[index].title,
                      date:
                          BlocProvider.of<HomeCubit>(context).sell[index].date,
                      city: BlocProvider.of<HomeCubit>(context)
                          .sell[index]
                          .location,

                      image: BlocProvider.of<HomeCubit>(context)
                          .sell[index]
                          .images[0],
                      onFavTap: () {},
                      productId: BlocProvider.of<HomeCubit>(context)
                          .sell[index]
                          .productId,
                      catId: BlocProvider.of<HomeCubit>(context)
                          .sell[index]
                          .categoryId,
                      isFav: true,
                      //await isLiked(
                          //BlocProvider.of<HomeCubit>(context).sell[index].categoryId,
                          //BlocProvider.of<HomeCubit>(context).sell[index].productId,
                        //),
                    )
                  : MainProductItem(
                      price:
                          BlocProvider.of<HomeCubit>(context).rent[index].price,
                      title:
                          BlocProvider.of<HomeCubit>(context).rent[index].title,
                      date:
                          BlocProvider.of<HomeCubit>(context).rent[index].date,
                      city: BlocProvider.of<HomeCubit>(context)
                          .rent[index]
                          .location,
                      isFav: false,
                      image: BlocProvider.of<HomeCubit>(context)
                          .rent[index]
                          .images[0],
                      onFavTap: () {},
                      productId: BlocProvider.of<HomeCubit>(context)
                          .rent[index]
                          .productId,
                      catId: BlocProvider.of<HomeCubit>(context)
                          .rent[index]
                          .categoryId,
                    );
              return InkWell(
                onTap: () {
                  push(
                      context,
                      ProductDetailsScreen(
                        productId: product.productId,
                        catId: product.catId,
                      ));
                },
                child: Container(
                    margin: EdgeInsets.only(right: 15.sp),
                    width: 60.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.4.sp, color: AppColors.offWhite),
                        color: AppColors.second,
                        borderRadius: BorderRadius.circular(10.sp)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppImage(
                          imageUrl: product.image,
                          width: 60.w,
                          height: 20.h,
                          topRightRadius: 10.sp,
                          topLeftRadius: 10.sp,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    product.price,
                                    style: TextStyle(
                                        color: AppColors.offWhite,
                                        fontSize: 17.sp),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    product.isFav
                                        ? Icons.favorite_outlined
                                        : Icons.favorite_outline,
                                    color: AppColors.offWhite,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.offWhite,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                product.city,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.offWhite,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                product.date,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.offWhite,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }
}
