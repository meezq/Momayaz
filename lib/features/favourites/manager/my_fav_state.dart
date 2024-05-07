part of 'add_favourite.dart';
@immutable
abstract class MyFavState {}

class MyFavInitial extends MyFavState {}
class MyFavLoading extends MyFavState {}
class MyFavSuccess extends MyFavState {}
class MyFavFailure extends MyFavState {}


class RemoveFavLoading extends MyFavState {}
class RemoveFavSuccess extends MyFavState {}
class RemoveFavFailure extends MyFavState {}