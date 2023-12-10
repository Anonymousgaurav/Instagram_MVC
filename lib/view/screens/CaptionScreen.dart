import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/controller/UploadVideoController.dart';
import 'package:insta_mvc_demo/utils/DeviceUtils.dart';
import 'package:insta_mvc_demo/view/styles/LoginScreenStyles.dart';
import 'package:insta_mvc_demo/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

class CaptionScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const CaptionScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<CaptionScreen> createState() => _CaptionScreenState();
}

class _CaptionScreenState extends State<CaptionScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController songNameController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  final videoController = Get.put(UploadVideoController());

  uploadVid() {
    uploadContent = Text(
      "Please Wait..",
      style: LoginScreenStyles.loginButton,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.9);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _textFieldContainer(
                    TextInputField(
                        controller: songNameController,
                        myIcon: Icons.music_note,
                        myLabelText: "Song Name"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _textFieldContainer(
                    TextInputField(
                        controller: captionController,
                        myIcon: Icons.closed_caption,
                        myLabelText: "Caption"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadVid();
                      videoController.uploadVideo(
                        widget.videoPath,
                        songNameController.text,
                        captionController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    child: uploadContent,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textFieldContainer(Widget child) {
    return Container(
        height: DeviceUtils.fractionHeight(context, fraction: 15.0),
        margin: const EdgeInsets.symmetric(
          horizontal: _DIMENS.MARGIN_HORIZONTAL,
        ),
        child: child);
  }
}

Widget uploadContent = Text(
  "Upload",
  style: LoginScreenStyles.loginButton,
);

abstract class _DIMENS {
  static const MARGIN_HORIZONTAL = 30.0;
}
