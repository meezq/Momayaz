part of 'chats_cubit.dart';

@immutable
abstract class ChatsState {}

class ChatsInitial extends ChatsState {}

class MessageSendSuccess extends ChatsState {}

class MessageGetSuccess extends ChatsState {}


