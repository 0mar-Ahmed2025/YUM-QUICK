import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:yum_quick/core/cache/cache_helper.dart';
import 'package:yum_quick/core/network/api_helper.dart';
import 'package:yum_quick/core/translation/translations_helper.dart';
import 'package:yum_quick/features/get_start/views/spalsh_veiw.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await APIHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: TranslationHelper(),
      locale: Locale('en'),
      title: 'Flutter Demo',
      home: SplashView(),
    );
  }
}
