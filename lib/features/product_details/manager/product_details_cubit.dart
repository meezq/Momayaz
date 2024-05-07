import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  late ProductModel productModel;
  final firestore = FirebaseFirestore.instance;



  void getProducts({required String id, required String productId}) {
    emit(ProductDetailsLoading());
    firestore
        .collection("categories")
        .doc(id)
        .collection(id)
        .doc(productId)
        .snapshots()
        .listen((value) async {
      safePrint("message");
      productModel = ProductModel.fromMap(value.id,value.data()!);
     safePrint(likesList.length);
      likes(id: id, productId: productId);
      safePrint(value.data());
      safePrint(value.toString());
      emit(ProductDetailsSuccess());
    }).onError((error) {

      emit(ProductDetailsFailure());
      safePrint("===============>$error");
    });
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
