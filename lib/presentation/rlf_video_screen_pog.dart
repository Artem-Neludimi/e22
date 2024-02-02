import 'package:e22/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class RLFVideoScreenPog extends StatefulWidget {
  const RLFVideoScreenPog({super.key});

  @override
  State<RLFVideoScreenPog> createState() => _RLFVideoScreenPogState();
}

class _RLFVideoScreenPogState extends State<RLFVideoScreenPog> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      Assets.video.rlfVideoPog,
    )..initialize().then((_) {
        _controller.play();
        setState(() {});
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            Navigator.of(context).pop();
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: 9 / 16,
                    child: VideoPlayer(_controller),
                  )
                : const CircularProgressIndicator(),
          ),
          Positioned(
            top: 25,
            right: 25,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
