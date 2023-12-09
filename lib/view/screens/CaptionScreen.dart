import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/controller/UploadVideoController.dart';
import 'package:insta_mvc_demo/view/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

import '../../utils/constants.dart';

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

  Widget uploadContent = const Text("Upload");

  uploadVid() {
    uploadContent = const Text("Please Wait..");
    setState(() {});
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
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputField(
                      controller: songNameController,
                      myIcon: Icons.music_note,
                      myLabelText: "Song Name"),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputField(
                      controller: captionController,
                      myIcon: Icons.closed_caption,
                      myLabelText: "Caption"),
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
                    style: ElevatedButton.styleFrom(primary: button),
                    child: uploadContent,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
