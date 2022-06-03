import 'package:cloud_firestore/cloud_firestore.dart';

class PostProvider {
  static Future<QuerySnapshot> getPosts(
    int limit, {
    DocumentSnapshot? startAfter,
  }) async {
    final refPost = FirebaseFirestore.instance.collection('posts').limit(limit);

    if (startAfter == null) {
      return refPost.get();
    } else {
      return refPost.startAfterDocument(startAfter).get();
    }
  }
}
