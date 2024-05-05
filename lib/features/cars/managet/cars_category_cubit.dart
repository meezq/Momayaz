import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:momayaz/features/cars/model/car_model.dart';

part 'cars_category_state.dart';

class CarsCategoryCubit extends Cubit<CarsCategoryState> {
  CarsCategoryCubit() : super(CarsCategoryInitial());
  FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;
  List<CarModel> cars = [];
  getCars(){
    emit(CarsCategoryLoading());
    firebaseFirestore.collection("cars").get().then((value) {
      cars.clear();
      for(var doc in value.docs){
        final category = CarModel.fromMap(doc.data());
        cars.add(category);
      }
      emit(CarsCategorySuccess());

    }).catchError((e){
      emit(CarsCategoryFailure(errorMessage: "$e"));

    });
  }
}
