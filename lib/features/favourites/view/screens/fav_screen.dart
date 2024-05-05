import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/features/product_details/manager/product_details_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:momayaz/features/favourites/manager/add_favourite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import category_products.dart
import 'package:momayaz/features/category_products/view/screens/category_products.dart';

class MyFavScreen extends StatefulWidget {
  const MyFavScreen({super.key});

  @override
  State<MyFavScreen> createState() => _MyFavScreenState();
}

class _MyFavScreenState extends State<MyFavScreen> {
  final cubit = MyFavCubit();

  @override
  void initState() {
    super.initState();
    cubit.getFav();
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
              "My Favourites",
              style: TextStyle(
                  color: AppColors.offWhite,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: BlocBuilder<MyFavCubit, MyFavState>(
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
