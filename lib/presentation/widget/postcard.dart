import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PostCard extends StatefulWidget {
  final bool isImage, isVideo;
  final String? mediaLink;
  final String? postText;
  PostCard(
      {Key? key,
      required this.isImage,
      required this.isVideo,
      required this.mediaLink,
      required this.postText})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late YoutubePlayerController _controller;
  bool _isPlayerReady = false;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.mediaLink.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;

    // TODO: implement initState
    super.initState();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 15.w,
                    ),
                    CircleAvatar(
                      minRadius: 23.w,
                      backgroundImage: NetworkImage(
                          "https://cdn.imgbin.com/2/4/15/imgbin-computer-icons-portable-network-graphics-avatar-icon-design-avatar-DsZ54Du30hTrKfxBG5PbwvzgE.jpg"),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pravin Nichal",
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                        ),
                        Text(
                          "30 minutes ago",
                          style: TextStyle(
                            color: Colors.grey[500],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        textStyle: TextStyle(
                          color: Colors.grey[800],
                        ),
                        side: BorderSide(
                          color: Colors.amber,
                        ),
                      ),
                      child: Text(
                        "Follow",
                        style: TextStyle(
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Icon(Icons.more_vert),
                    SizedBox(
                      width: 10.w,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(widget.postText.toString()),
            ),
            if (widget.isVideo)
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  _controller.addListener(listener);
                },
              ),
            if (widget.isImage)
              Image.network(
                widget.mediaLink.toString(),
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.center,
              ),
            if (!widget.isImage && !widget.isVideo) Divider(),
            if (widget.isImage || widget.isVideo)
              SizedBox(
                height: 10.h,
              ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.amber,
                        size: 20.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "133 Likes",
                        style: TextStyle(fontSize: 11.sp),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "30 comments",
                        style: TextStyle(fontSize: 11.sp),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.copy,
                        size: 20.w,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Icon(
                        Icons.bookmark_outline,
                        size: 20.w,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.thumb_up_alt_outlined,
                  ),
                  Icon(
                    Icons.comment_outlined,
                  ),
                  Icon(
                    Icons.share,
                  ),
                  Icon(
                    Icons.download,
                  )
                ],
              ),
            ),
            Divider(thickness: 1),
          ],
        ));
  }
}
