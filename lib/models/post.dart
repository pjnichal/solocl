class Post {
  final String postText;
  final String postId;
  final String? mediaLink;
  final bool isImage, isVideo;
  Post({
    required this.postId,
    required this.postText,
    required this.mediaLink,
    required this.isVideo,
    required this.isImage,
  });
}
