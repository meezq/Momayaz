part of 'cars_category_cubit.dart';

@immutable
sealed class CarsCategoryState {}

final class CarsCategoryInitial extends CarsCategoryState {}
final class CarsCategorySuccess extends CarsCategoryState {}
final class CarsCategoryLoading extends CarsCategoryState {}
final class CarsCategoryFailure extends CarsCategoryState {
 final  String errorMessage;

 CarsCategoryFailure({required this.errorMessage});
}
