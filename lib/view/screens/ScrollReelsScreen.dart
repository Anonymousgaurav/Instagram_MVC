import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/controller/NotificationController.dart';
import 'package:insta_mvc_demo/controller/VideoController.dart';
import 'package:insta_mvc_demo/view/screens/CommentsScreen.dart';
import 'package:insta_mvc_demo/view/screens/ProfileScreen.dart';
import 'package:insta_mvc_demo/view/widgets/video_player/ProfileImage.dart';
import 'package:insta_mvc_demo/view/widgets/video_player/VideoPlayer.dart';

class ScrollReelsScreen extends StatelessWidget {
  ScrollReelsScreen({super.key});

  final VideoController videoController = Get.put(VideoController());
  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemCount: videoController.videoList.length,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              return InkWell(
                onDoubleTap: () {
                  videoController.likedVideo(data.id);
                  // notificationController.likeNotification(data.id);
                },
                child: Stack(
                  children: [
                    AppVideoPlayer(
                      videoUrl: data.videoUrl,
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10, left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.username,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Text(
                            data.caption,
                          ),
                          Text(
                            data.songName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 400,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3,
                            right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfileScreen(
                                              uid: data.uid,
                                            )));
                              },
                              child: ProfileImage(
                                profilePhotoUrl: data.profilePic,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                videoController.likedVideo(data.id);
                                // notificationController.likeNotification(data.id);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 25,
                                    color: data.likes.contains(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        ? Colors.pinkAccent
                                        : Colors.white,
                                  ),
                                  Text(
                                    data.likes.length.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                share(data.id);
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.reply,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.shareCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CommentsScreen(id: data.id)));
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.comment,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.commentsCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      // AlbumRotator(
                                      //     profilePicUrl: data.profilePic)
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      }),
    );
  }

  Future<void> share(String vidId) async {
    await FlutterShare.share(
      title: 'Download My TikTok Clone App',
      text: 'Watch Intresting short videos On TikTok Clone',
    );
    videoController.shareVideo(vidId);
  }
}
