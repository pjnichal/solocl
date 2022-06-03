import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:solocl/models/post.dart';
import 'package:solocl/providers/postprovider.dart';

class PostRepository {
  final _postSnapshot = <DocumentSnapshot>[];

  Future<List<Post>> fetchFirst() async {
    List<Post> finalList = [];

    try {
      final snap = await PostProvider.getPosts(10);

      _postSnapshot.addAll(snap.docs);

      _postSnapshot.forEach((e) {
        finalList.add(Post(
            isImage: e['isImage'],
            isVideo: e['isVideo'],
            mediaLink: e['mediaLink'],
            postText: e['postText'],
            postId: e.id));
      });
    } catch (e) {
      print(e);
    }

    return finalList;
  }

  Future<List<Post>> fetchNextPost() async {
    List<Post> finalList = [];

    try {
      final snap = await PostProvider.getPosts(10,
          startAfter: _postSnapshot.isNotEmpty ? _postSnapshot.last : null);
      _postSnapshot.addAll(snap.docs);
    } catch (e) {
      print(e);
    }

    _postSnapshot.forEach((e) {
      finalList.add(Post(
          isImage: e['isImage'],
          isVideo: e['isVideo'],
          mediaLink: e['mediaLink'],
          postText: e['postText'],
          postId: e.id));
    });
    return finalList;
  }
}
