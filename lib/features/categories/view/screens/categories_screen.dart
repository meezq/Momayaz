import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/widgets/categories_item.dart';
import 'package:momayaz/features/category_products/view/screens/category_products.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.cats, required this.carCategoryId});
final String carCategoryId;
  final List cats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Categories",
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
                return CategoriesItem(
                  icon: cats[index].image,
                  title: cats[index].category,
                  onTap: () {
                    push(
                      context,
                      CategoryProducts(
                        id: cats[index].id,
                        category: cats[index].category, carCatId: carCategoryId,
                      ),
                    );
                  },
                );
              },
              itemCount: cats.length,
            ),
          )
        ],
      ),
    );
  }
}
