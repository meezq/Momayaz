import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/utils/safe_print.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  List<ProductModel> productModel = [];
  List<String> likesList = [];
  bool isLiked = false;
  final firestore = FirebaseFirestore.instance;
  TextEditingController searchC = TextEditingController();


  Future<void> getProductsSearch({required String value}) async {
    emit(SearchLoading());

    firestore.collection("categories")
        .doc("1").collection("1")
        .snapshots()
        .listen((value)  async {
      safePrint("message");
      productModel.clear();
      safePrint("========>${value.docs.length}");
      for (var document in value.docs) {
        if (document['title'].toString().toLowerCase().contains(searchC.text.toLowerCase())) {
          safePrint("loop");

          final category = ProductModel.fromMap(document.id,document.data());
          productModel.add(category);
          await likes(id: "1", productId: document['id'] ,index: productModel.length-1);

          safePrint(productModel.length);
        }
      }
      emit(SearchSuccess());
    });
  }

  Future likes({required String id, required String productId,int index = 0}) async{
    emit(LikesLoading());
    firestore
        .collection("categories")
        .doc(id)
        .collection(id)
        .doc(productId).collection("likes").get().then((value) {

      for(var doc in value.docs){
        if(doc['liked_by'] ==MyShared.getString(key: MySharedKeys.userid) ){
          productModel[index].isLiked = true;
        }
        safePrint(isLiked);
      }


      emit(LikesSuccess());

    }).catchError((onError){
      safePrint(onError.toString());
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
      safePrint('removing');
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
