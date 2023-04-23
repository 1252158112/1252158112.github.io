import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vcommunity_flutter/components/selective_card.dart';
import 'package:vcommunity_flutter/constants.dart';

class ToolScreenPage extends StatelessWidget {
  const ToolScreenPage({super.key});
  @override
  Widget build(BuildContext context) {
    List tools = [
      {
        'link': '/tool/library_tool',
        'name': '图书馆预约签到',
        'author': 'Lejw',
        'icon': Icons.local_library_rounded,
        'introduce':
            '基于Flutter开发的额外工具插件，旨在帮助用户跳过校园网的网关验证，实现进入在线图书馆位置预约和扫码签到的功能。',
        'canUsePlatform': [CanUsePlatform.mobile]
      }
    ];
    List<Widget> toolList = [];
    for (var i in tools) {
      toolList.add(SelectiveCardWidget(i['link'], i['name'], i['author'],
          i['icon'], i['introduce'], i['canUsePlatform']));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('发现'),
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: '提示', middleText: '发现页面提供的内容是不稳定的，内容随时可能更改');
            },
            icon: const Icon(Icons.info),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: ListView(
          children: [
            Card(
                margin: const EdgeInsets.only(top: defaultPadding),
                elevation: 0,
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding / 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.volume_down_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Expanded(
                        child: Text(
                          "这里提供一些正在开发的功能。部分功能并不支持所有平台使用，欢迎反馈",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: defaultPadding,
            ),
            ...toolList
          ],
        ),
      ),
    );
  }
}
