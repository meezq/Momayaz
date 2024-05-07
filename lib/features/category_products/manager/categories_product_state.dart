part of 'categories_product_cubit.dart';

abstract class CategoriesProductState {}
class CategoriesProductInitial extends CategoriesProductState {}
class CategoriesProductLoading extends CategoriesProductState {}
class CategoriesProductSuccess extends CategoriesProductState {}
class CategoriesProductFailure extends CategoriesProductState {}

class LikesLoading extends CategoriesProductState {}
class LikesSuccess extends CategoriesProductState {}
class LikesFailure extends CategoriesProductState {}

class UpdateLikeLoading extends CategoriesProductState {}
class UpdateLikeSuccess extends CategoriesProductState {}
class AddLikeFailure extends CategoriesProductState {}
