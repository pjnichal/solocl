import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solocl/presentation/widget/postcard.dart';

import '../logic/bloc/postbloc_bloc.dart';
import '../models/post.dart';

class MyCity extends StatefulWidget {
  const MyCity({Key? key}) : super(key: key);

  @override
  State<MyCity> createState() => _MyCityState();
}

class _MyCityState extends State<MyCity> {
  final controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        BlocProvider.of<PostblocBloc>(context).add(PostFetchLater());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostblocBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading && state.isFirstFetch) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.amber,
          ));
        }
        List<Post> posts = [];
        if (state is PostLoading) {
          posts = state.oldPost;
        } else if (state is PostLoaded) {
          posts = state.post;
        }

        return ListView.builder(
            itemCount: posts.length + 1,
            controller: controller,
            itemBuilder: ((context, index) {
              if (!(index < posts.length)) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.amber,
                    ),
                  ),
                );
              } else {
                return PostCard(
                  postText: posts[index].postText,
                  isImage: posts[index].isImage,
                  isVideo: posts[index].isVideo,
                  mediaLink: posts[index].mediaLink,
                );
              }
            }));
      },
    );
  }
}
