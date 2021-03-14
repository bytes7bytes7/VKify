import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vkify/scr/ui/theme/themes.dart';
import 'package:flutter_vkify/scr/ui/views/login/login_view.dart';
import 'package:flutter_vkify/scr/ui/views/start/start_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VKify',
      theme: darkThemeData,
      home: LoginView(),
    );
  }
}
