import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<MainProductItem> products = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.offWhite),
        backgroundColor: AppColors.second,
      ),
      backgroundColor: AppColors.second,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(13.sp),
            child: Text(
              "Favourites",
              style: TextStyle(
                  color: AppColors.offWhite,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return products[index];
              },
              itemCount: products.length,
            ),
          ),
        ],
      ),
    );
  }
}
