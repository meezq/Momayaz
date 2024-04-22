import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';
import 'package:momayaz/features/my_ads/manager/my_ads_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  final cubit = MyAdsCubit();

  @override
  void initState() {
    super.initState();
    cubit.getAds();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(13.sp),
            child: Text(
              "My Ads",
              style: TextStyle(
                  color: AppColors.offWhite,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: BlocBuilder<MyAdsCubit, MyAdsState>(
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return MainProductItem(
                      price: cubit.products[index].price,
                      title: cubit.products[index].title,
                      date: cubit.products[index].date,
                      city: cubit.products[index].location,
                      isFav: false,
                      image: cubit.products[index].images[0],
                      onFavTap: () {},
                      productId: cubit.products[index].productId,
                      catId: cubit.products[index].categoryId,
                    );
                  },
                  itemCount: cubit.products.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
