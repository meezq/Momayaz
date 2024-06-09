import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momayaz/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/core/utils/navigators.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/core/widgets/app_button.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';
import 'package:momayaz/features/bookings/manager/my_bookings_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final cubit = MyBookingsCubit();

  @override
  void initState() {
    super.initState();
    cubit.getBookings();
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
              "Booked Products",
              style: TextStyle(
                  color: AppColors.offWhite,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: BlocBuilder<MyBookingsCubit, MyBookingsState>(
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (context, index) {

safePrint('message');
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
