import 'dart:ui';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shortcuts/flutter_shortcuts.dart';
import 'package:get/get.dart';
import 'package:vcommunity_flutter/Page/Tool/LibraryTool/util/http_util.dart';
import 'package:vcommunity_flutter/Page/Tool/LibraryTool/util/state_util.dart';
import 'package:vcommunity_flutter/constants.dart';
import 'package:vcommunity_flutter/util/http_util.dart';
import 'package:vcommunity_flutter/util/user_state_util.dart';
import 'Page/home_page.dart';
import 'dart:ui' as ui;
import 'routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Set<PointerDeviceKind> kTouchLikeDeviceTypes = <PointerDeviceKind>{
      PointerDeviceKind.touch,
      PointerDeviceKind.mouse,
      PointerDeviceKind.stylus,
      PointerDeviceKind.invertedStylus,
      PointerDeviceKind.unknown
    };
    Get.put(UserStateUtil());
    Get.put(HttpUtil());
    Get.put(FlutterShortcuts());
    // LibraryTool
    Get.put(LibraryHttpUtil());
    Get.put(LibraryStateUtil());
    final FlutterShortcuts flutterShortcuts = Get.find();
    final LibraryStateUtil libraryStateUtil = Get.find();
    flutterShortcuts.initialize(debug: true);

    flutterShortcuts.listenAction((String incomingAction) {
      if (incomingAction == 'toScanPage') {
        Get.toNamed('/tool/library_tool/scan');
      } else if (incomingAction.contains('toSignSeat')) {
        String link = incomingAction.split('@@@')[1];
        libraryStateUtil.signLink = link;
        Get.toNamed('/tool/library_tool/signSeat');
      }
    });

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return GetMaterialApp(
          locale: ui.window.locale,
          scrollBehavior: const MaterialScrollBehavior()
              .copyWith(scrollbars: true, dragDevices: kTouchLikeDeviceTypes),
          debugShowCheckedModeBanner: false,
          title: '足记',
          unknownRoute: GetPage(name: '/notfound', page: () => HomePage()),
          initialRoute: '/',
          getPages: routes,
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            fontFamily: 'OPlusSans3',
            colorSchemeSeed: darkDynamic?.primary ?? seed,
            cardTheme: const CardTheme(
              elevation: 0,
              color: Colors.black,
              margin: EdgeInsets.all(defaultPadding),
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize),
                ),
              ),
            ),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize),
                ),
              ),
            ),
          ),
          themeMode: ThemeMode.system,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'OPlusSans3',
            colorSchemeSeed: lightDynamic?.primary ?? seed,
            scaffoldBackgroundColor: ColorScheme.fromSeed(
              seedColor: lightDynamic?.primary ?? seed,
            ).onInverseSurface,
            appBarTheme: AppBarTheme(
              backgroundColor: ColorScheme.fromSeed(
                seedColor: lightDynamic?.primary ?? seed,
              ).onInverseSurface,
            ),
            cardTheme: CardTheme(
              elevation: 0,
              color: ColorScheme.fromSeed(
                seedColor: lightDynamic?.primary ?? seed,
              ).background,
              margin: const EdgeInsets.all(defaultPadding),
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize),
                ),
              ),
            ),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize),
                ),
              ),
            ),
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
