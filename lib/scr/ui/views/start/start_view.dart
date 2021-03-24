import 'package:flutter/material.dart';
import 'package:flutter_vkify/scr/app/services/auth_service.dart';
import 'package:flutter_vkify/scr/ui/views/home/home_view.dart';
import 'package:flutter_vkify/scr/ui/views/login/login_view.dart';

class StartView extends StatelessWidget {

  Future<void> checkLoggedIn(BuildContext context)async{
    await VKClient.checkCookie();
    if(VKClient.userID==null){
      print('no user id');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginView()));
    }
    else
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeView()));
  }

  @override
  Widget build(BuildContext context) {
    checkLoggedIn(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
    );
  }
}
