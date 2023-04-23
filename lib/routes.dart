import 'package:get/get.dart';
import 'package:vcommunity_flutter/MiddleWare/user_login_middleware.dart';
import 'package:vcommunity_flutter/Page/Blog/Editor/blog_edit_screen.dart';
import 'package:vcommunity_flutter/Page/Blog/blog_detail_screen.dart';
import 'package:vcommunity_flutter/Page/Explore/Building/BuildingAdd/building_add_screen.dart';
import 'package:vcommunity_flutter/Page/Explore/Building/building_detail_screen.dart';
import 'package:vcommunity_flutter/Page/Explore/Topic/TopicAdd/topic_add_screen.dart';
import 'package:vcommunity_flutter/Page/Explore/Topic/topic_detail_screen.dart';
import 'package:vcommunity_flutter/Page/Search/search_screen.dart';
import 'package:vcommunity_flutter/Page/Tool/tool_screen.dart';
import 'package:vcommunity_flutter/Page/User/Info/components/user_information_screen.dart';
import 'package:vcommunity_flutter/Page/User/Info/info_edit.dart';
import 'package:vcommunity_flutter/Page/User/Welcome/welcome_screen.dart';
import 'package:vcommunity_flutter/components/image_display.dart';
import 'Page/Tool/LibraryTool/pages/LibraryHomePage.dart';
import 'Page/Tool/LibraryTool/pages/ScanPage.dart';
import 'Page/Tool/LibraryTool/pages/SignSeatPage.dart';
import 'Page/Tool/LibraryTool/pages/UpdateInfoPage.dart';
import 'Page/Tool/LibraryTool/pages/WebviewPage.dart';
import 'Page/User/Login/login_screen.dart';
import 'Page/User/Signup/signup_screen.dart';
import 'Page/home_page.dart';

List<GetPage> routes = [
  GetPage(
    name: '/',
    page: () => HomePage(),
  ),
  GetPage(
    name: '/imageView',
    page: () => ImageDisplayScreen(),
  ),
  GetPage(
    name: '/welcome',
    page: () => WelcomeScreen(),
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
  ),
  GetPage(
    name: '/signup',
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: '/search',
    page: () => SearchScreen(),
  ),
  GetPage(
    name: '/user/:userId',
    page: () => UserEditScreen(),
    middlewares: [UserMiddleWare()],
  ),
  GetPage(
    name: '/topic/add',
    page: () => TopicAddScreen(),
    middlewares: [UserMiddleWare()],
  ),
  GetPage(
    name: '/topic/:topicId',
    page: () => TopicDetailScreen(),
  ),
  GetPage(
    name: '/topic/edit/:topicId',
    page: () => TopicAddScreen(),
    middlewares: [UserMiddleWare()],
  ),
  GetPage(
    name: '/building/add',
    page: () => BuildingAddScreen(),
    middlewares: [UserMiddleWare()],
  ),
  GetPage(
    name: '/building/edit/:buildingId',
    page: () => BuildingAddScreen(),
    middlewares: [UserMiddleWare()],
  ),
  GetPage(
    name: '/building/:buildingId',
    page: () => BuildingDetailScreen(),
  ),
  GetPage(
      name: '/blog/add',
      page: () => BlogEditScreen(),
      middlewares: [UserMiddleWare()]),
  GetPage(
    name: '/blog/:blogId',
    page: () => BlogDetailScreen(),
  ),
  GetPage(
    name: '/tool',
    page: () => ToolScreenPage(),
  ),
  GetPage(
    name: '/tool/library_tool',
    page: () => const LibraryHomePage(),
  ),
  GetPage(
    name: '/tool/library_tool/webview',
    page: () => const LibraryWebviewPage(),
  ),
  GetPage(
    name: '/tool/library_tool/scan',
    page: () => LibraryScanPage(),
  ),
  GetPage(
    name: '/tool/library_tool/signSeat',
    page: () => LibrarySignSeatPage(),
  ),
  GetPage(
    name: '/tool/library_tool/updateInfo',
    page: () => LibraryUpdateInfoPage(),
  ),
];
