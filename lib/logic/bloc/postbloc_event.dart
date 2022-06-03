part of 'postbloc_bloc.dart';

@immutable
abstract class PostblocEvent {}

class PostFetchFirst extends PostblocEvent {}

class PostFetchLater extends PostblocEvent {}
