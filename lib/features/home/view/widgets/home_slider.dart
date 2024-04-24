import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momayaz/features/home/manager/home_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeGetAdsSuccess,
      builder: (context, state) {
        return CarouselSlider(
          items: BlocProvider.of<HomeCubit>(context).ads.map((e) {
            return Card(
              shape: const RoundedRectangleBorder(),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => BlocProvider.of<HomeCubit>(context)
                      .appLaunchUrl(Uri.parse(e.url)),
                  child: Image.network(
                    e.image,
                    width: double.infinity,
                    height: 40.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlayCurve: Curves.decelerate,
            autoPlay: BlocProvider.of<HomeCubit>(context).ads.length > 1
                ? true
                : false,
            height: 40.h,
            viewportFraction: 1,
          ),
        );
      },
    );
  }
}
