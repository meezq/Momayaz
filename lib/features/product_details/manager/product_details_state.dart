part of 'product_details_cubit.dart';

abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}
class ProductDetailsLoading extends ProductDetailsState {}
class ProductDetailsSuccess extends ProductDetailsState {}
class ProductDetailsFailure extends ProductDetailsState {}


class LikesLoading extends ProductDetailsState {}
class LikesSuccess extends ProductDetailsState {}
class LikesFailure extends ProductDetailsState {}

class UpdateLikeLoading extends ProductDetailsState {}
class UpdateLikeSuccess extends ProductDetailsState {}
class AddLikeFailure extends ProductDetailsState {}


