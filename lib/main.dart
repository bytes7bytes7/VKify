import 'package:flutter/material.dart';
import 'package:flutter_vkify/scr/ui/theme/light_theme.dart';
import 'package:flutter_vkify/scr/ui/views/login/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VKify',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      home: LoginView(),
    );
  }
}
