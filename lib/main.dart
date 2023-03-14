import 'dart:ui';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return GetMaterialApp(
          locale: ui.window.locale,
          scrollBehavior: const MaterialScrollBehavior()
              .copyWith(scrollbars: true, dragDevices: kTouchLikeDeviceTypes),
          debugShowCheckedModeBanner: false,
          title: '语事',
          unknownRoute: GetPage(name: '/notfound', page: () => HomePage()),
          initialRoute: '/',
          getPages: routes,
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
            cardTheme: const CardTheme(
              elevation: 0,
              color: Colors.white,
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
          home: const HomePage(),
        );
      },
    );
  }
}
