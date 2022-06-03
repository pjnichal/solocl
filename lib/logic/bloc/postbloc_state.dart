part of 'postbloc_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoaded extends PostState {
  final List<Post> post;

  PostLoaded(this.post);
  @override
  List<Object> get props => [post];
}

class PostLoading extends PostState {
  final List<Post> oldPost;
  final bool isFirstFetch;

  PostLoading(this.oldPost, {this.isFirstFetch = false});
  @override
  List<Object> get props => [oldPost, isFirstFetch];
}
