
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:bloc/bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/features/favourites/model/fav_model.dart';
import 'package:momayaz/core/utils/safe_print.dart';
part 'my_fav_state.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
String userId = MyShared.getString(key: MySharedKeys.userid);

class MyFavCubit extends Cubit<MyFavState> {
  MyFavCubit() : super(MyFavInitial());
  List<FavModel> fProducts = [];

  List<ProductModel> products= [];

  void getFav() {
    emit(MyFavLoading());
    firestore
        .collection('users')
        .doc(userId)
        .collection('fav')
        .get()
        .then((value) {
      fProducts.clear();
      products.clear();
      for (var document in value.docs) {
        fProducts.add(FavModel.fromMap( document.data()));
        // firestore.collection('categories')
        //   .doc(fProducts[i].category)
        //   .collection(fProducts[i].category)
        //   .doc(fProducts[i].id)
        //   .snapshots()
        //   .listen((value) {

         // products.add(ProductModel.fromMap(value.id, value.data()!));

        safePrint("${document['id']}++${document['category']}");

        firestore.collection("categories").doc(document['category']).collection(document['category']).doc(document['id']).get().then((value) {

          safePrint("message");
          products.add(ProductModel.fromMap(document.id, value.data()!));
          safePrint("=========> products${products.length}");

          emit(MyFavSuccess());

        }).catchError((onError){
          safePrint(onError.toString());
        });
        }



      safePrint(fProducts[0]);

      safePrint("===>"+fProducts.length.toString());
        //  i++;
      }
      


    );
  }





  void removeFav({required String catId,required String productId,required int index}){
    emit(RemoveFavLoading());
    firestore
        .collection('users')
        .doc(userId)
        .collection('fav')
        .doc(productId).delete().then((value) {
          products.removeAt(index);
          firestore.collection('categories').doc(catId).collection(catId).doc(productId).collection("likes")
          .doc(userId).delete().then((value) {

          });
          emit(RemoveFavSuccess());

          safePrint("removed");
    }).catchError((onError){
      safePrint(onError.toString());
    });

  }



}

