import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/controller/CommentsController.dart';
import 'package:timeago/timeago.dart' as tago;

import '../widgets/text_input.dart';

class CommentsScreen extends StatelessWidget {
  final String id;

  CommentsScreen({super.key, required this.id});

  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostID(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(comment.profilePic),
                          ),
                          title: Row(
                            children: [
                              Text(
                                comment.username,
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                comment.comments,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                tago.format(comment.datePub.toDate()),
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${comment.likes.length} Likes",
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () {
                              commentController.likeComment(comment.id);
                            },
                            child: Icon(
                              Icons.favorite,
                              color: comment.likes.contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      });
                }),
              ),
              const Divider(),
              const SizedBox(
                height: 15.0,
              ),
              ListTile(
                title: SizedBox(
                  height: 44.0,
                  child: TextInputField(
                    controller: _commentController,
                    myIcon: Icons.comment,
                    myLabelText: "Comment",
                  ),
                ),
                trailing: TextButton(
                  onPressed: () {
                    commentController.postComment(_commentController.text);
                  },
                  child: const Text("Send"),
                ),
              ),
              const SizedBox(
                height: 25.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
