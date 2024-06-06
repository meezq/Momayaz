part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}
final class SearchLoading extends SearchState {}
final class SearchSuccess extends SearchState {}


class LikesLoading extends SearchState {}
class LikesSuccess extends SearchState {}
class LikesFailure extends SearchState {}

class UpdateLikeLoading extends SearchState {}
class UpdateLikeSuccess extends SearchState {}
class AddLikeFailure extends SearchState {}
