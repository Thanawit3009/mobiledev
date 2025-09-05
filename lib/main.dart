import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'di/injection.dart';
import 'presentation/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();     // persist
  await setupInjection();      // DI: get_it + GetX
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokémon Team Builder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: MainPage(),
      // ตัวอย่าง deep-link-like (เว็บ): routes/named ได้
      getPages: [
        GetPage(name: '/', page: () => MainPage()),
        // GetPage(name: '/preview', page: () => TeamPreviewPage()), // ถ้าอยากใช้ชื่อเส้นทาง
      ],
    );
  }
}
