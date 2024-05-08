import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/utils/safe_print.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  List<ProductModel> productModel = [];
  final firestore = FirebaseFirestore.instance;
  TextEditingController searchC = TextEditingController();


  Future<void> getProductsSearch({required String value}) async {
    emit(SearchLoading());

    firestore.collection("categories")
        .doc("1").collection("1").where("name" , isEqualTo: searchC.text.toUpperCase())
        .snapshots()
        .listen((value)  {
      safePrint("message");
      productModel.clear();

      safePrint("========>${value.docs.length}");
      for (var document in value.docs) {
        safePrint("loop");
        final category = ProductModel.fromMap(document.id,document.data());
        productModel.add(category);
        safePrint(productModel.length);
      }
      emit(SearchSuccess());
    });
  }

}
