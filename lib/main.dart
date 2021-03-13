import 'package:flutter/material.dart';
import 'package:flutter_vkify/scr/app/services/link_decoder.dart';
import 'package:flutter_vkify/scr/ui/theme/light_theme.dart';
import 'package:flutter_vkify/scr/ui/views/login/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LinkDecoder ld = LinkDecoder(180320356);
  dynamic r = ld.decode('https://vk.com/mp3/audio_api_unavailable.mp3?extra=AfeVnNHSAgyTBLvYwersBZfmEuLnBtvNneK4m2uZEs85yLHHzxnYzfLOlwXyEgXKp3zHC2TblNqYDK0OwwrVvY9UDfPpyxbAmtaOseTMqMz4zg81svbgsdq4ANHxnOCOBt1ulK5Vmurfl18YtwfLEMG3AwrHr1fMBgm1Dg51C29LnOH1zdf1BdfLmvPWy3rfuZrUnZnypwzjCdHiDI9jyK1UnMT6uxG6AKPNCg5LmhjYjNnuDJC3DdrgDgLxvvqWn2LcnY43AtvOzKXRrgHnz3bQy1vnqJDyn1HxDve2EKuYrg8VnKW1DwzQzg84u1HZovrenMm#AqS2ntC');
  print(r);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VKify',
      theme: lightThemeData,
      home: LoginView(),
    );
  }
}
