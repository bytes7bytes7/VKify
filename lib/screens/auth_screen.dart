import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:flutter_vkify/screens/home_screen.dart';
import 'package:flutter_vkify/services/login.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Dio dio;
  bool loading;
  String error;
  String phone, password;
  ScrollController controller;
  TextEditingController phoneController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    loading = false;
    error = '';
    phone = '';
    password = '';
    controller = ScrollController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,
      backgroundColor: Color(0xFFECF5FF),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
        width: double.infinity,
        height: size.height,
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            controller: controller,
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 110,
                width: 150,
                child: SvgPicture.asset(
                  'assets/svg/vkify.svg',
                ),
              ),
              SizedBox(height: 50.0),
              TextField(
                onChanged: (value) {
                  if(error!=''){
                    setState(() {
                      error='';
                    });
                  }
                  phone = value;
                },
                controller: phoneController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'E-mail or phone',
                  hintText: 'name@exam.com or +799999999999',
                  hintStyle: TextStyle(
                    color: Color(0xFFA6B6C8),
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  if(error!=''){
                    setState(() {
                      error='';
                    });
                  }
                  password = value;
                },
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Password',
                  hintText: 'password',
                  hintStyle: TextStyle(
                    color: Color(0xFFA6B6C8),
                  ),
                ),
              ),
              SizedBox(
                height: 80.0,
                child: (error != '')
                    ? Container(
                  alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          error,
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
              SizedBox(
                width: double.infinity,
                height: 45.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Color(0xFF479CFF),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (phone != '' && password != '' && !loading) {
                      error = '';
                      loading = true;
                      dio = await login(phone, password);
                      loading = false;
                      if (dio != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      } else {
                        setState(() {
                          error = 'Не удалось войти!';
                        });
                      }
                    }else{
                      setState(() {
                        error = 'Заполните все поля!';
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
