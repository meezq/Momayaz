import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/features/home/model/ads_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:momayaz/features/home/model/categories_model.dart';
//import 'package:url_launcher/url_launcher.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final firestore = FirebaseFirestore.instance;
  List<Ads> ads = [];
  List<ProductModel> sell = [];
  List<ProductModel> rent = [];
  List<Categories> cats = [];

  void getHome() {
    emit(HomeGetProductsLoading());
    firestore.collection("categories").doc("1").collection("1").get().then((value) {
      sell.clear();
      rent.clear();
      for (var document in value.docs) {
        final product = ProductModel.fromMap(document.id,document.data());
        if(product.vType=='sale'){
          sell.add(product);
        }
        else{
          rent.add(product);
        }
        emit(HomeGetProductsSuccess());
      }
    }).catchError((error) {
      emit(HomeGetProductsFailure());
      safePrint(error);
    });
  }

  void getCats() {
    emit(HomeGetCatLoading());
    firestore.collection("categories").get().then((value) {
      cats.clear();
      for (var document in value.docs) {
        final category = Categories.fromMap(document.data());
        cats.add(category);
        emit(HomeGetCatSuccess());
      }
    }).catchError((error) {
      emit(HomeGetCatFailure());
      safePrint(error);
    });
  }

  Future<void> getAds() async {
    await firestore.collection('ads').get().then((value) {
      ads.clear();
      for (var document in value.docs) {
        final ad = Ads.fromMap(document.data());
        ads.add(ad);
        emit(HomeGetAdsSuccess());
      }
    }).catchError((error) {
      emit(HomeGetAdsFailure());
      safePrint(error);
    });
  }

  Future<void> appLaunchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  
  launchUrl(Uri url) {}
}
