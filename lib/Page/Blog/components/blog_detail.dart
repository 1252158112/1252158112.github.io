import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcommunity_flutter/Model/blog.dart';

import '../../../components/quill_config.dart';
import '../../../constants.dart';
import '../../../util/string_util.dart';

class BlogDetailWidget extends StatefulWidget {
  Blog blog;
  BlogDetailWidget(this.blog, {super.key});

  @override
  State<BlogDetailWidget> createState() => _BlogDetailWidgetState();
}

class _BlogDetailWidgetState extends State<BlogDetailWidget> {
  final PageController _pageController = PageController();
  var _picIndex = 0;
  late Blog blog;

  @override
  void initState() {
    super.initState();
    blog = widget.blog;
  }

  @override
  Widget build(BuildContext context) {
    bool hasTitle = blog.title != '';
    List<Widget> imageList = [];
    List<Widget> topicList = [];
    List<Widget> indicater = [];
    Size size = MediaQuery.of(context).size;
    double picHeight = min(size.height * 0.6, 350);
    int picLen = blog.images.split(',').length;
    bool noPic = false;
    for (var i in blog.images.split(',')) {
      if (i == '') {
        noPic = true;
        break;
      }
      imageList.add(
        InkWell(
          onTap: () {
            Get.toNamed("/imageView?path=$api$i");
          },
          child: Hero(
            tag: api + i,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(api + i), fit: BoxFit.contain),
                ),
              ),
            ),
          ),
        ),
      );
    }
    for (int i = 0; i < picLen; i++) {
      indicater.add(InkWell(
        onTap: () {
          _pageController.jumpToPage(i);
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          height: 7,
          width: 7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: _picIndex == i
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.primaryContainer),
        ),
      ));
    }
    for (var i in blog.topics) {
      topicList.add(
        Padding(
          padding: const EdgeInsets.only(right: defaultPadding / 3),
          child: TextButton.icon(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                minimumSize: const Size(1, 1),
                padding: const EdgeInsets.all(3)),
            onPressed: () => Get.toNamed('/topic/${i.id}'),
            icon: CircleAvatar(
              backgroundImage: NetworkImage(i.icon),
              radius: 7,
            ),
            label: Text(
              i.name,
              style: const TextStyle(fontSize: 10, height: 1),
            ),
          ),
        ),
      );
    }
    List<Widget> imageWidget = noPic
        ? []
        : [
            SizedBox(
              height: picHeight,
              child: PageView(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _picIndex = value;
                  });
                },
                children: imageList,
              ),
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: indicater,
            ),
          ];
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: defaultPadding / 2,
          ),
          ...imageWidget,
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hasTitle
                    ? Text(
                        blog.title,
                        maxLines: 2,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .fontSize),
                      )
                    : const SizedBox(),
                Container(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                  child: QuillConfig().onlyShowLarge(context, blog.content),
                ),
                Row(
                  children: topicList,
                ),
                Text(
                  '发布于${blog.createTime.toString().split(' ').first}',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.outline),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
