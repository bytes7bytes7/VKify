import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:flutter_vkify/scr/app/services/auth_service.dart';
import 'package:flutter_vkify/scr/app/services/music_provider.dart';
import '../home/home_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Dio dio;
  bool loading;
  String error,status;
  String phone, password;
  ScrollController controller;
  TextEditingController phoneController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    VKClient.initCookie();
    loading = false;
    error = '';
    phone = '';
    status='';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFECF5FF),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: controller,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 10.0),
                  width: double.infinity,
                  height: constraints.maxHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Spacer(),
                      SizedBox(
                        height: 110,
                        width: 150,
                        child: SvgPicture.asset(
                          'assets/svg/vkify.svg',
                        ),
                      ),
                      //SizedBox(height: 50.0),
                      Spacer(),
                      TextField(
                        scrollPadding: EdgeInsets.all(10.0),
                        onChanged: (value) {
                          if (error != '') {
                            setState(() {
                              error = '';
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
                        scrollPadding: EdgeInsets.all(10.0),
                        onChanged: (value) {
                          if (error != '') {
                            setState(() {
                              error = '';
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
                      Spacer(flex: 2),
                      SizedBox(
                        height: 40.0,
                        child: (status != '')
                            ? Container(
                          alignment: Alignment.bottomCenter,
                          padding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            status,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                            : SizedBox.shrink(),
                      ),
                      SizedBox(
                        height: 40.0,
                        child: (error != '')
                            ? Container(
                                alignment: Alignment.bottomCenter,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  error,
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            : SizedBox.shrink(),
                      ),
                      SizedBox(
                        height: 45.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF479CFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: () async {
                            print('loading: $loading');
                            if (phone != '' && password != '' && !loading) {
                              error = '';
                              loading = true;
                              dio = await VKClient.login(phone, password);
                              loading = false;
                              if (dio != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeView(),
                                  ),
                                );
                              } else {
                                setState(() {
                                  error = 'Не удалось войти!';
                                  loading=false;
                                });
                              }
                            } else {
                              setState(() {
                                error = 'Заполните все поля!';
                                loading=false;
                              });
                            }
                          },
                        ),
                      ),SizedBox(height: 20.0),
                      SizedBox(
                        height: 45.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF479CFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Text(
                            'Fetch',
                            style:
                            TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          onPressed: () async {
                            status= await MusicProvider.fetchMusic();
                            setState(() {

                            });
                          }
                        ),
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(
                        height: 45.0,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF479CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              'Delete',
                              style:
                              TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () async {
                              VKClient.cookieJar.deleteAll();
                            }
                        ),
                      ),
                      SizedBox(
                        height: 45.0,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF479CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              'Headers',
                              style:
                              TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () async {
                              VKClient.showHeaders();
                            }
                        ),
                      ),
                      SizedBox(
                        height: 45.0,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF479CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              'CookieJar',
                              style:
                              TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () async {
                              VKClient.showCookieJar();
                            }
                        ),
                      ),
                      SizedBox(
                        height: 45.0,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF479CFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              'Load Headers',
                              style:
                              TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () async {
                              VKClient.loadHeaders();
                            }
                        ),
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
