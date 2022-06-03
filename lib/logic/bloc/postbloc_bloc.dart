import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:solocl/repositories/postRepository.dart';

import '../../models/post.dart';

part 'postbloc_event.dart';
part 'postbloc_state.dart';

class PostblocBloc extends Bloc<PostblocEvent, PostState> {
  PostblocBloc() : super(PostInitial()) {
    on<PostblocEvent>((event, emit) async {
      List<Post> posts = [];
      final PostRepository postRepository = PostRepository();
      if (event is PostFetchFirst) {
        final currentState = state;
        var oldPost = <Post>[];
        emit(PostLoading(oldPost, isFirstFetch: true));
        var value = await postRepository.fetchFirst();

        posts.addAll(value);

        emit(PostLoaded(posts));
      }
      if (event is PostFetchLater) {
        await Future.delayed(Duration(seconds: 1));
        final currentState = state;
        var oldPost = <Post>[];
        if (currentState is PostLoaded) {
          oldPost = currentState.post;
        }
        emit(PostLoading(oldPost, isFirstFetch: false));

        var value = await postRepository.fetchNextPost();
        final posts1 = (state as PostLoading).oldPost;
        posts1.addAll(value);
        emit(PostLoaded(posts1));
      }
    });
  }
}
