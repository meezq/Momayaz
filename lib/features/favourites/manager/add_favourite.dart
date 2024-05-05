import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/models/fav_model.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/features/category_products/view/screens/category_products.dart';

part 'my_fav_state.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
String userId = MyShared.getString(key: MySharedKeys.userid);

class MyFavCubit extends Cubit<MyFavState> {
  MyFavCubit() : super(MyFavInitial());
  List<FavProductModel> fproducts = [];
  List<ProductModel> products= [];

  void getFav() {
    emit(MyFavLoading());
    firestore
        .collection('users')
        .doc(userId)
        .collection('fav')
        .get()
        .then((value) {
      fproducts.clear();
      int i = 0;
      for (var document in value.docs) {
        fproducts.add(FavProductModel.fromMap(document.id, document.data()));
        firestore.collection('categories')
          .doc(fproducts[i].categoryId)
          .collection(fproducts[i].categoryId)
          .doc(fproducts[i].productId)
          .snapshots()
          .listen((value) {
          safePrint("message");
          products.add(ProductModel.fromMap(value.id, value.data()!));
          safePrint(products.length);
           emit(MyFavSuccess());
        });
          i++;
      }
      
              

    }).catchError((error) {
      emit(MyFavFailure());
      safePrint("=========7======>$error");
    });
  }
}

void addFav({
  required String catId,
  required String id,
}) {
  firestore
      .collection("categories")
      .doc(catId)
      .collection(catId)
      .doc(id)
      .collection("likes")
      .doc(userId)
      .set({
    "liked_by": userId,
    "liked_on": FieldValue.serverTimestamp(), // to record the time of the like
  });
  firestore
      .collection("categories")
      .doc(catId)
      .collection(catId)
      .doc(id)
      .get()
      .then((value) {
    firestore.collection("users").doc(userId).collection("fav").doc(id).set({
      "id": id,
      "category": catId,
    });
  });
}

Future<bool> isLiked(String catId, String id) async {
  // Attempt to fetch the document
  DocumentSnapshot snapshot = await firestore
      .collection("categories")
      .doc(catId)
      .collection(catId)
      .doc(id)
      .collection("likes")
      .doc(userId)
      .get();
  // Return true if the document exists, false otherwise
  return snapshot.exists;
}
