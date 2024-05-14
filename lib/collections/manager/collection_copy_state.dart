part of 'collection_copy_cubit.dart';

@immutable
sealed class CollectionCopyState {}

final class CollectionCopyInitial extends CollectionCopyState {}
final class CollectionLoading extends CollectionCopyState {}
final class CollectionSuccess extends CollectionCopyState {}
