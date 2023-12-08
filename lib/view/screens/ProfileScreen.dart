import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/controller/ProfileController.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUseId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: Text('${controller.user["name"]}'),
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              body: controller.user.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: controller.user['ProfilePic'],
                                    fit: BoxFit.contain,
                                    height: 100,
                                    width: 100,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['followers'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Followers",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['following'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Followings",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.user['likes'],
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("Likes",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white60, width: 0.6),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(widget.uid ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? "Sign Out"
                                        : controller.user['isFollowing']
                                            ? "Following"
                                            : "Follow")),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              indent: 30,
                              endIndent: 30,
                              thickness: 2,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 5),
                                itemCount: controller.user['thumbnails'].length,
                                itemBuilder: (context, index) {
                                  String thumbnail =
                                      controller.user['thumbnails'][index];
                                  return CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: thumbnail,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  );
                                })
                          ],
                        ),
                      ),
                    ));
        });
  }
}
