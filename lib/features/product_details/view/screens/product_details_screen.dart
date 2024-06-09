import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/core/widgets/app_image.dart';
import 'package:momayaz/core/widgets/congrats_screen.dart';
import 'package:momayaz/features/chats/view/screens/chat_screen.dart';
import 'package:momayaz/features/product_details/manager/product_details_cubit.dart';
import 'package:momayaz/features/product_details/view/widgets/product_details_header.dart';
import 'package:momayaz/features/product_details/view/widgets/product_details_widget.dart';
import 'package:momayaz/features/product_details/view/widgets/slider_details.dart';
import 'package:momayaz/features/user_ads/view/screens/user_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {super.key, required this.productId, required this.catId});

  final String productId;
  final String catId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final cubit = ProductDetailsCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          cubit..getProducts(id: widget.catId, productId: widget.productId),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Scaffold(
              backgroundColor: AppColors.second,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              bottomNavigationBar: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
  listener: (context, state) {
    // TODO: implement listener
    if (state is BookingSuccess) {
      pushReplacement(
        context,
        const AppCongrats(
          title: "Product Booked!,\n verify with the provider within 3 days.",
          icon: "done.png",
        ),
      );
    }
  },
  builder: (context, state) {
    return BottomNavigationBar(
                backgroundColor: Colors.grey[900],
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                      label: '',
                      icon: InkWell(
                        onTap:() {cubit.addBooking(catId: widget.catId, productId: widget.productId);
                          
                          },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          padding: EdgeInsets.all(15.sp),
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(13.sp),
                              border: Border.all(color: AppColors.primary)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.book,
                                color: AppColors.primary,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                "Book",
                                style: TextStyle(
                                    color: AppColors.offWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              )
                            ],
                          ),
                        ),
                      )),

                  BottomNavigationBarItem(
                      label: '',
                      icon: InkWell(
                        onTap: () => push(
                            context,
                            ChatScreen(
                              receiverId: cubit.productModel.userId,
                              receiverName: cubit.productModel.userName,
                              userName: cubit.productModel.userName,
                            )),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.sp),
                          padding: EdgeInsets.all(15.sp),
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(13.sp),
                              border: Border.all(color: AppColors.primary)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.wechat_sharp,
                                color: AppColors.primary,
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Text(
                                "Chat",
                                style: TextStyle(
                                    color: AppColors.offWhite,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp),
                              )
                            ],
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: '',
                      icon: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.sp),
                        padding: EdgeInsets.all(15.sp),
                        decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(13.sp),
                            border: Border.all(color: AppColors.primary)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.call,
                              color: AppColors.offWhite,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            const Text(
                              "Call",
                              style: TextStyle(
                                  color: AppColors.offWhite,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )),
                ],
              );
  },
),
              backgroundColor: Colors.grey[900],
              body: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constrains) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constrains.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SliderDetails(
                                imgList: cubit.productModel.images,
                              ),
                              ProductDetailsHeader(
                                name: cubit.productModel.title,
                                price: "${cubit.productModel.price} EGP",
                                location: cubit.productModel.location,
                                date: cubit.productModel.date,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                                child: Divider(
                                  color: AppColors.offWhite,
                                  thickness: 1.5.sp,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              ProductDetailsWidget(
                                type: cubit.productModel.vType,
                                description: cubit.productModel.description,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                                child: Divider(
                                  color: AppColors.offWhite,
                                  thickness: 1.5.sp,
                                ),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                padding: EdgeInsets.all(15.sp),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.productModel.userName,
                                          style: TextStyle(
                                            color: AppColors.offWhite,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () => push(
                                                context,
                                                UserAdsScreen(
                                                  id: cubit.productModel.userId,
                                                  name: cubit
                                                      .productModel.userName,
                                                  image: cubit
                                                      .productModel.userImage,
                                                ),
                                              ),
                                              child: Text(
                                                "See profile",
                                                style: TextStyle(
                                                    color: AppColors.primary,
                                                    fontSize: 18.sp),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.h,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 16.sp,
                                              color: AppColors.primary,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Visibility(
                                      visible:
                                          cubit.productModel.userImage == ''
                                              ? false
                                              : true,
                                      replacement: Container(
                                        width: 20.w,
                                        height: 10.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius:
                                              BorderRadius.circular(14.sp),
                                        ),
                                        child: Text(
                                          cubit.productModel.userName
                                              .substring(0, 1),
                                          style: TextStyle(
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      child: AppImage(
                                        imageUrl: cubit.productModel.userImage,
                                        width: 20.w,
                                        height: 10.h,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 25.sp, bottom: 17.sp, left: 15.sp, right: 15.sp),
                    color: Colors.black.withOpacity(0.4),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.offWhite,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            if (cubit.isLiked == true) {
                              cubit.removeFav(
                                  catId: cubit.productModel.categoryId,
                                  productId: cubit.productModel.productId);
                              setState(() {});
                            } else {
                              cubit.addFav(
                                  productId: cubit.productModel.productId,
                                  catId: cubit.productModel.categoryId);
                              setState(() {});
                            }
                          },
                          child: Icon(
                            cubit.isLiked == true
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: AppColors.offWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
