import 'package:momayaz/features/home/manager/home_cubit.dart';
import 'package:momayaz/features/home/view/widgets/home_app_bar.dart';
import 'package:momayaz/features/home/view/widgets/home_categories_wdget.dart';
import 'package:momayaz/features/home/view/widgets/home_slider.dart';
import 'package:momayaz/features/home/view/widgets/products_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = HomeCubit();

  @override
  void initState() {
    super.initState();
    cubit.getHome();
    cubit.getAds();
    cubit.getCats();
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => cubit,
      child: Container(
        margin: EdgeInsets.all(13.sp),
        child: LayoutBuilder(
          builder: (context, constrains) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constrains.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const HomeAppBar(),
                    HomeCategoriesWidgets(
                      cats: cubit.cats,
                    ),
                    const HomeSlider(),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) => cubit.sell.isEmpty
                          ? const SizedBox()
                          : const ProductsItem(
                              title: 'Cars For Sale',
                            ),
                    ),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) => cubit.rent.isEmpty
                          ? const SizedBox()
                          : const ProductsItem(
                              title: 'New Cars',
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  likeButton(
      {required int size, required Icon Function(bool isLiked) likedBuilder}) {}
}
