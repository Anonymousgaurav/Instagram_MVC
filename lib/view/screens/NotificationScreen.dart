import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:insta_mvc_demo/controller/CommentsController.dart';
import 'package:insta_mvc_demo/controller/NotificationController.dart';
import 'package:timeago/timeago.dart' as tago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    controller.fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Obx(() {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.notification.length,
            itemBuilder: (context, index) {
              final notification = controller.notification[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(notification.profilePic),
                ),
                title: Row(
                  children: [
                    Text(
                      notification.username,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      notification.msg,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      tago.format(notification.datePub.toDate()),
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
