import 'package:flutter/material.dart';
import 'package:flutter_vkify/scr/app/services/auth_service.dart';
import 'package:flutter_vkify/scr/ui/views/login/login_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var dio = VKClient.dio;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(dio.interceptors.toString()),
              Text(VKClient.userID.toString()),
              Text(VKClient.username),
              Text(VKClient.avatarUrl),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  primary: Color(0xFF479CFF),
                ),
                child: Text(
                  'Fetch Music',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {

                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  primary: Color(0xFF479CFF),
                ),
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
