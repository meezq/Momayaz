import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/features/home/model/ads_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:momayaz/features/home/model/categories_model.dart';
import 'package:url_launcher/url_launcher.dart';

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



  List<String> likesList = [];
  bool isLiked = false;
  Future likes({required String id, required String productId}) async{
    emit(LikesLoading());
    firestore
        .collection("categories")
        .doc(id)
        .collection(id)
        .doc(productId).collection("likes").snapshots().listen((value) {

      for(var doc in value.docs){
        if(doc['liked_by'] ==MyShared.getString(key: MySharedKeys.userid) ){
          isLiked = true;

        }
      }
      emit(LikesSuccess());

    });


  }
  void addFav({required String catId, required String productId,}) {
    emit(UpdateLikeLoading());
    firestore
        .collection("categories")
        .doc(catId)
        .collection(catId)
        .doc(productId)
        .collection("likes")
        .doc(MyShared.getString(key: MySharedKeys.userid))
        .set({
      "liked_by": MyShared.getString(key: MySharedKeys.userid),
      "liked_on": FieldValue.serverTimestamp(), // to record the time of the like
    }).then((value) {
      likes(id: catId,productId: productId);
      safePrint("added");
      firestore
          .collection("categories")
          .doc(catId)
          .collection(catId)
          .doc(productId)
          .get()
          .then((value) {
        firestore.collection("users").doc(MyShared.getString(key: MySharedKeys.userid)).collection("fav").doc(productId).set({
          "id": productId,
          "category": catId,
        });

      });
      emit(UpdateLikeSuccess());
    });

  }
  void removeFav({required String catId,required String productId}){
    emit(UpdateLikeLoading());
    firestore
        .collection('users')
        .doc(MyShared.getString(key: MySharedKeys.userid))
        .collection('fav')
        .doc(productId).delete().then((value) {
      firestore.collection('categories').doc(catId).collection(catId).doc(productId).collection("likes")
          .doc(MyShared.getString(key: MySharedKeys.userid)).delete().then((value) {
        isLiked = false;
        likes(id: catId, productId:productId);
      });
      emit(UpdateLikeSuccess());

      safePrint("removed");
    }).catchError((onError){
      safePrint(onError.toString());
    });

  }




}
