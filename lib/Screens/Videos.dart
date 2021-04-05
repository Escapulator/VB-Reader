import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final Duration stopAt;

  Video({this.looping, @required this.videoPlayerController, this.stopAt});
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  bool isAnswered = false;
  bool showVideo = true;
  bool restart = true;
  bool showControls = true;
  ChewieController _controller;
  @override
  void initState() {
    super.initState();
    initializeController();
  }

  void initializeController() {
    _controller = new ChewieController(
      // stopAt: widget.stopAt,
      autoPlay: false,
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      startAt: Duration(seconds: 0),
      looping: widget.looping,
      showControls: showControls,
      errorBuilder: (context, errorMessage) {
        return Text(
          errorMessage,
          textAlign: TextAlign.center,
        );
      },
    );
    if (!isAnswered) {
      widget.videoPlayerController.addListener(() {
        if (widget.videoPlayerController.value.position >=
            widget.stopAt && restart) {
          print('The stop position and reached and is stopped ${widget.videoPlayerController.value.position.toString()}');
          restart = false;
          changeStateOfTheVideo();
        }
      });
    }
  }

  void changeStateOfTheVideo() {
    _controller.pause();
    setState(() {
      print('changing state');
      showVideo = false;
      restart = true;
      showControls = true;
    });
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (showVideo)
          ? Container(
              height: MediaQuery.of(context).size.height * .3,
              child: Chewie(controller: _controller),
            )
          : Center(
              child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height * .3,
                  child: Icon(Icons.repeat),
                ),
                onTap: () {
                  // widget.videoPlayerController.initialize();
                  widget.videoPlayerController.seekTo(Duration(seconds: 0));
                  restart = true;
                  setState(() {
                    showVideo = true;
                  });
                },
              ),
            ),
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.pause();
    super.dispose();
    widget.videoPlayerController.dispose();
    _controller.dispose();
  }
}
