import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter_app/view/home/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controller/get_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HomeGetController homeGetController = Get.put(HomeGetController());
  runApp(const MyApp());
}

HomeGetController homeGetController = Get.put(HomeGetController());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: (!homeGetController.themeSetting.value)?ThemeMode.light:ThemeMode.dark,
        getPages: [
          GetPage(
            name: "/",
            page: () => const HomePage(),
          ),
        ],
      ),
    );
  }
}
