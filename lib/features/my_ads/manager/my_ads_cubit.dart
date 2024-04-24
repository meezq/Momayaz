import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/utils/safe_print.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  MyAdsCubit() : super(MyAdsInitial());
  List<ProductModel> products = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getAds() {
    emit(MyAdsLoading());
    firestore
        .collection('users')
        .doc(MyShared.getString(key: MySharedKeys.userid))
        .collection('ads')
        .get()
        .then((value) {
      products.clear();
      for (var document in value.docs) {
        products.add(ProductModel.fromMap(document.id,document.data()));
        safePrint(products.length);
        emit(MyAdsSuccess());
      }
    }).catchError((error) {
      emit(MyAdsFailure());
      safePrint("===============>$error");
    });
  }
}
