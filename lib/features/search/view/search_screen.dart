import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/core/widgets/app_text_field.dart';
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
                  child: AppTextField(hint: "Search",

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
                ),
                SizedBox(height: 2.h,),
                Expanded(

                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: cubit.productModel.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            cubit.productModel[index].vName, style: const TextStyle(
                              color: Colors.white
                          ),);
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
