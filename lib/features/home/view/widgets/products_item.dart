import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/widgets/app_image.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductsItem extends StatefulWidget {
  const ProductsItem({super.key, required this.title});

  final String title;

  @override
  State<ProductsItem> createState() => _ProductsItemState();
}

class _ProductsItemState extends State<ProductsItem> {
  List<MainProductItem> sell = [
    MainProductItem(
      price: 'EGP 9,000,000',
      title: 'Mercedes AMG GT 63',
      date: '1 month ago.',
      city: 'El kersh',
      bed: 0,
      bath: 0,
      area: 0,
      isFav: true,
      image: 'https://i.ibb.co/LdYMkFJ/pexels-mike-bird-112460.jpg',
      onFavTap: () {},
      productId: '',
      catId: '',
    ),
    MainProductItem(
      price: 'EGP 5,000,000',
      title: 'Jeep Grand Cherokee',
      date: '3 month ago.',
      city: 'El kersh',
      bed: 0,
      bath: 0,
      area: 0,
      isFav: true,
      image: 'https://i.ibb.co/SP6wv5D/pexels-aaron-curtis-119435.jpg',
      onFavTap: () {},
      productId: '',
      catId: '',
    ),
  ];
  List<MainProductItem> rent = [
    MainProductItem(
      price: 'EGP 5000/day',
      title: 'Mercedes AMG GT 63',
      date: '1 month ago.',
      city: 'El kersh',
      bed: 0,
      bath: 0,
      area: 0,
      isFav: false,
      image: 'https://i.ibb.co/LdYMkFJ/pexels-mike-bird-112460.jpg',
      onFavTap: () {},
      productId: '',
      catId: '',
    ),
    MainProductItem(
      price: 'EGP 3000',
      title: 'Jeep Grand Cherokee',
      date: '3 month ago.',
      city: 'El kersh',
      bed: 0,
      bath: 0,
      area: 0,
      isFav: false,
      image: 'https://i.ibb.co/SP6wv5D/pexels-aaron-curtis-119435.jpg',
      onFavTap: () {},
      productId: '',
      catId: '',
    ),
  ];

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
                  /// on Taaaaaaaaaaaaaap
                },
                child: Text(
                  "see all",
                  style: TextStyle(color: AppColors.offWhite, fontSize: 15.sp),
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
        Container(
          color: AppColors.second,
          height: 40.h,
          child: ListView.builder(
            itemCount:
                widget.title == 'Cars For Sale' ? sell.length : rent.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              MainProductItem product =
                  widget.title == 'Cars For Sale' ? sell[index] : rent[index];
              return InkWell(
                onTap: () {
                  // push(
                  //     context,
                  //     ProductDetailsScreen(
                  //       productId: '',
                  //       catId: '',
                  //     ));
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
