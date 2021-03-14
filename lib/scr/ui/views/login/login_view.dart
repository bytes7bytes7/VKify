import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vkify/scr/app/services/auth_service.dart';
import 'package:flutter_vkify/scr/ui/global/app_colors.dart';
import '../home/home_view.dart';
import 'package:flutter_vkify/scr/ui/global/loading.dart';
import 'package:flutter_vkify/scr/ui/global/constants.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool loading;
  String error;
  ScrollController controller;
  TextEditingController phoneController;
  TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    VKClient.initCookie();
    loading = false;
    error = '';
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
      backgroundColor: Theme.of(context).backgroundColor,
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
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.centerLeft,
                      radius: 1.2,
                      colors: [
                        darkGradientColors[2],
                        Colors.transparent,
                      ],
                    ),
                  ),
                  width: double.infinity,
                  height: constraints.maxHeight,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.bottomLeft,
                        radius: 1.2,
                        colors: [
                          darkGradientColors[1],
                          Colors.transparent,
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: constraints.maxHeight,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment.topLeft,
                          radius: 1.2,
                          colors: [
                            darkGradientColors[0],
                            Colors.transparent,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      width: double.infinity,
                      height: constraints.maxHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Spacer(flex: 2),
                          SizedBox(
                            height: 110,
                            width: 150,
                            child: SvgPicture.asset(
                              darkLogo,
                            ),
                          ),
                          Spacer(),
                          TextField(
                            scrollPadding: EdgeInsets.all(10.0),
                            controller: phoneController,
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                            ),
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Эл.почта / телефон',
                              hintText: '+7 777 777-77-77',
                              labelStyle: TextStyle(
                                color: Theme.of(context).focusColor,
                              ),
                              hintStyle: TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextField(
                            scrollPadding: EdgeInsets.all(10.0),
                            obscureText: true,
                            controller: passwordController,
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                            ),
                            decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              labelText: 'Пароль',
                              hintText: 'Пароль',
                              labelStyle: TextStyle(
                                color: Theme.of(context).focusColor,
                              ),
                              hintStyle: TextStyle(
                                color: Theme.of(context).disabledColor,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 40.0,
                            child: (error != '')
                                ? Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Text(
                                      error,
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor),
                                    ),
                                  )
                                : SizedBox.shrink(),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 55.0,
                                vertical: 15.0,
                              ),
                              child: Text(
                                'Войти',
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                            onPressed: () async {
                              print('loading: $loading');
                              if (phoneController.text != '' && passwordController.text != '' && !loading) {
                                error = '';
                                loading = true;
                                showLoading(context);
                                VKClient.cookieJar.deleteAll();
                                bool done = await VKClient.login(phoneController.text, passwordController.text);
                                loading = false;
                                Navigator.pop(context);
                                if (done) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeView(),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    error = 'Не удалось войти!';
                                    loading = false;
                                  });
                                }
                              } else {
                                setState(() {
                                  error = 'Заполните все поля!';
                                  loading = false;
                                });
                              }
                            },
                          ),
                          Spacer(flex: 3),
                        ],
                      ),
                    ),
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
