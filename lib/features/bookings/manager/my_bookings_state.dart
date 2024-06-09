part of 'my_bookings_cubit.dart';



@immutable
abstract class MyBookingsState {}

class MyBookingsInitial extends MyBookingsState {}
class MyBookingsLoading extends MyBookingsState {}
class MyBookingsSuccess extends MyBookingsState {}
class MyBookingsFailure extends MyBookingsState {}
