
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:momayaz/core/models/product_model.dart';
import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/utils/safe_print.dart';

part 'my_bookings_state.dart';

class MyBookingsCubit extends Cubit<MyBookingsState> {
  MyBookingsCubit() : super(MyBookingsInitial());
  List<ProductModel> products = [];
  //ProductModel product=ProductModel('_productId', '_dimensions', '_title', '_category', '_categoryId', '_price', '_date', '_description', '_location', '_userName', '_userId', '_userImage', '_images' as List?, '_vName', '_vModel', '_vColor', '_vType', '_shippingType', '_carServiceType', '_partType', false);
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getBookings() {
    emit(MyBookingsLoading());
    firestore
        .collection('users')
        .doc(MyShared.getString(key: MySharedKeys.userid))
        .collection('ads')
        .get()
        .then((value) {
      products.clear();
      for (var document in value.docs) {
        firestore.collection('bookings').get().then((value) {
          for (var documents in value.docs){
          if(ProductModel.fromMap(documents.id,document.data()).productId== ProductModel.fromMap(document.id,document.data()).productId){
            products.add(ProductModel.fromMap(document.id,document.data()));
            safePrint('${products.length} ddhhhd');
            safePrint(products);


          }

          }
        });
        emit(MyBookingsSuccess());
      }

      safePrint('${products.length} ddd');

    }).catchError((error) {
      emit(MyBookingsFailure());
      safePrint("===============>$error");
    });
  }
}
