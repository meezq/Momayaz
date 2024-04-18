import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:momayaz/core/widgets/main_product_item.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  MyAdsCubit() : super(MyAdsInitial());
  List<MainProductItem> products = [
    MainProductItem(
      price: 'EGP 9,000,000',
      title:
          'Mercedes AMG GT 63',
      date: '1 month ago.',
      city: 'El kersh',
      bed: 0,
      bath: 0,
      area: 0,
      isFav: true,
      image:
          'https://i.ibb.co/LdYMkFJ/pexels-mike-bird-112460.jpg',
      onFavTap: () {},
      productId: '',
      catId: '',
    ),
    MainProductItem(
      price: 'EGP 5,000,000',
      title:
      'Jeep Grand Cherokee',
      date: '3 month ago.',
      city: 'El kersh',
      bed: 0,
      bath: 0,
      area: 0,
      isFav: true,
      image:
      'https://i.ibb.co/SP6wv5D/pexels-aaron-curtis-119435.jpg',
      onFavTap: () {},
      productId: '',
      catId: '',
    ),
  ];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
