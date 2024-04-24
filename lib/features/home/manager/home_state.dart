part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeGetCatLoading extends HomeState {}

class HomeGetCatSuccess extends HomeState {}

class HomeGetCatFailure extends HomeState {}

class HomeGetProductsLoading extends HomeState {}

class HomeGetProductsSuccess extends HomeState {}

class HomeGetProductsFailure extends HomeState {}

class HomeGetAdsSuccess extends HomeState {}

class HomeGetAdsFailure extends HomeState {}
