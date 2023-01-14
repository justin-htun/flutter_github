import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../config/app_config.dart';
import 'routes/app_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _AppState();
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: spaceGreyLightColor,
          textTheme:
          const TextTheme(displayMedium: TextStyle(fontSize: 20))),
      title: appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
