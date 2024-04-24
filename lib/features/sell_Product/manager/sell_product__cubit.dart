import 'package:momayaz/core/shared/my_shared.dart';
import 'package:momayaz/core/shared/my_shared_keys.dart';
import 'package:momayaz/core/utils/safe_print.dart';
import 'package:momayaz/features/sell_Product/model/shipping_model.dart';
import 'package:momayaz/features/sell_Product/model/car_service_model.dart';
import 'package:momayaz/features/sell_Product/model/sell_base_model.dart';
import 'package:momayaz/features/sell_Product/model/sell_part.dart';
import 'package:momayaz/features/sell_Product/model/vehicles_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

part 'sell_product__state.dart';

class SellProductCubit extends Cubit<SellProductState> {
  SellProductCubit() : super(SellProductInitial());
  final mainFormKey = GlobalKey<FormState>();

  TextEditingController priceEditingController = TextEditingController();

  TextEditingController titleEditingController = TextEditingController();

  TextEditingController descriptionEditingController = TextEditingController();

  TextEditingController vehiclesNameEditingController = TextEditingController();

  TextEditingController vehiclesColorEditingController =
      TextEditingController();

  TextEditingController vehiclesModelEditingController =
      TextEditingController();

  TextEditingController vehiclesTypeEditingController = TextEditingController();

  SingleValueDropDownController partType = SingleValueDropDownController();

  TextEditingController dimensionsEditingController = TextEditingController();

  TextEditingController carServiceTypeEditingController =
      TextEditingController();
  SingleValueDropDownController location = SingleValueDropDownController();

  TextEditingController shippingTypeEditingController =
      TextEditingController();


  void sellProduct({
    required String catId,
    SellBaseModel? sellBaseModel,
    VehiclesModel? vehiclesModel,
    PartModel? propertyModel,
    CarServiceModel? mobilesModel,
    ShippingModel? appliancesModel,
  }) {
    emit(SellProductLoading());
    String id = DateTime.now().millisecond.toString();
    FirebaseFirestore.instance
        .collection("categories")
        .doc(catId)
        .collection(catId)
        .doc(id)
        .set(sellBaseModel!.toJson())
        .then((value) {
      FirebaseFirestore.instance
          .collection("categories")
          .doc(catId)
          .collection(catId)
          .doc(id)
          .update({"id": id}).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(MyShared.getString(key: MySharedKeys.userid))
            .collection("ads")
            .doc(id)
            .set(sellBaseModel.toJson());
      }).then((value) {
        if (catId == "1") {
          sellVehicles(vehiclesModel: vehiclesModel, id: id);

          FirebaseFirestore.instance
              .collection('users')
              .doc(MyShared.getString(key: MySharedKeys.userid))
              .collection("ads")
              .doc(id)
              .update(vehiclesModel!.toJson());
          emit(SellProductSuccess());
        } else if (catId == '2') {
          sellParts(id: id, propertyModel: propertyModel);
          FirebaseFirestore.instance
              .collection('users')
              .doc(MyShared.getString(key: MySharedKeys.userid))
              .collection("ads")
              .doc(id)
              .update(propertyModel!.toJson());
          emit(SellProductSuccess());
        } else if (catId == '3') {
          sellCarService(id: id, mobilesModel: mobilesModel);
          FirebaseFirestore.instance
              .collection('users')
              .doc(MyShared.getString(key: MySharedKeys.userid))
              .collection("ads")
              .doc(id)
              .update(mobilesModel!.toJson());
          emit(SellProductSuccess());
        } else if (catId == "4") {
          sellShipping(id: id, appliancesModel: appliancesModel);
          FirebaseFirestore.instance
              .collection('users')
              .doc(MyShared.getString(key: MySharedKeys.userid))
              .collection("ads")
              .doc(id)
              .update(appliancesModel!.toJson());
          emit(SellProductSuccess());
        }
      });
      safePrint("done");
    }).catchError((error) {
      safePrint(error.toString());
    });
  }

  void sellVehicles({VehiclesModel? vehiclesModel, required String id}) {
    FirebaseFirestore.instance
        .collection("categories")
        .doc("1")
        .collection('1')
        .doc(id)
        .update(vehiclesModel!.toJson())
        .then((value) {});
  }

  void sellParts({PartModel? propertyModel, required String id}) {
    FirebaseFirestore.instance
        .collection("categories")
        .doc("2")
        .collection('2')
        .doc(id)
        .update(propertyModel!.toJson())
        .then((value) {});
  }

  void sellCarService({CarServiceModel? mobilesModel, required String id}) {
    FirebaseFirestore.instance
        .collection("categories")
        .doc("3")
        .collection('3')
        .doc(id)
        .update(mobilesModel!.toJson())
        .then((value) {});
  }

  void sellShipping({ShippingModel? appliancesModel, required String id}) {
    FirebaseFirestore.instance
        .collection("categories")
        .doc("4")
        .collection('4')
        .doc(id)
        .update(appliancesModel!.toJson())
        .then((value) {});
  }
}
