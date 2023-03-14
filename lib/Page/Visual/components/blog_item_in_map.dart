import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Model/blog.dart';
import '../../../components/quill_config.dart';
import '../../../constants.dart';

class BlogItemInMap extends StatelessWidget {
  Blog blog;
  String dateInfo = '';
  String distInfo = '';
  BlogItemInMap(this.blog, {super.key});
  @override
  Widget build(BuildContext context) {
    bool isMale = blog.user?.gender ?? false;
    bool hasTitle = blog.title != '';
    List<Widget> imageList = [];
    List<Widget> topicList = [];
    List<Widget> posList = [];
    dateInfo = calculateTimeDifference(blog.createTime);
    distInfo = calculateLocationDifference(blog.distanceValue);
    return Hero(
      tag: '/blog/${blog.id}',
      child: Container(
        padding: const EdgeInsets.fromLTRB(
            defaultPadding / 4, defaultPadding / 4, defaultPadding / 4, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.shadow.withAlpha(50),
                offset: const Offset(4, 3.4),
                blurRadius: 6,
                spreadRadius: 1.5)
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 38),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundImage:
                        NetworkImage(blog.user?.icon ?? defaultAvatar),
                  ),
                  const SizedBox(
                    width: defaultPadding / 2,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              blog.user?.nickName ?? '已删除用户',
                              style: TextStyle(
                                fontSize: 8,
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ),
                            Icon(
                              isMale
                                  ? Icons.female_rounded
                                  : Icons.male_rounded,
                              color: isMale ? Colors.pinkAccent : Colors.blue,
                              size: 8,
                            ),
                          ],
                        ),
                        Text(
                          dateInfo,
                          style: TextStyle(
                            fontSize: 7,
                            color: Theme.of(context).colorScheme.outline,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          distInfo,
                          style: TextStyle(
                            fontSize: 7,
                            color: Theme.of(context).colorScheme.outline,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: const Size(15, 10),
                      padding: const EdgeInsets.all(defaultPadding / 3),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed('/blog/${blog.id}');
                    },
                    child: const Icon(Icons.view_agenda_rounded),
                  )
                ],
              ),
            ),
            hasTitle
                ? Text(
                    blog.title,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                        fontSize: 8),
                  )
                : const SizedBox(),
            Expanded(
              child: AbsorbPointer(
                child: Container(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  clipBehavior: Clip.hardEdge,
                  // constraints: const BoxConstraints(maxHeight: 30),
                  decoration: const BoxDecoration(),
                  child: QuillConfig().onlyShowSmall(context, blog.content),
                ),
              ),
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius)),
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: defaultPadding / 6,
                runSpacing: defaultPadding / 6,
                children: imageList,
              ),
            ),
            Row(
              children: topicList,
            ),
          ],
        ),
      ),
    );
  }

  String calculateTimeDifference(DateTime datetime) {
    DateTime now = DateTime.now();
    Duration diff = now.difference(datetime);

    if (diff.inSeconds < 60) {
      return "不足一分钟前";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} 分钟前";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} 小时前";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} 天前";
    } else {
      return "${datetime.year} 年 ${datetime.month} 月 ${datetime.day} 日";
    }
  }

  String calculateLocationDifference(double distance) {
    if (distance == -1) {
      return '';
    }
    if (distance < 60) {
      return "不足60m";
    } else if (distance < 100) {
      return "不足100m";
    } else if (distance < 500) {
      return "不足500m";
    } else if (distance < 1000) {
      return "不足1km";
    } else {
      return "${distance ~/ 1000}km";
    }
  }
}
