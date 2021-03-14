import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_vkify/scr/app/services/auth_service.dart';
import 'package:flutter_vkify/scr/ui/widgets/search_bar.dart';
import 'package:flutter_vkify/scr/app/services/music_provider.dart';
import 'package:flutter_vkify/scr/ui/views/login/login_view.dart';
import 'package:flutter_vkify/scr/ui/global/next_page_route.dart';
import 'package:flutter_vkify/scr/ui/global/loading.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _sigmaX = 25;
  double _sigmaY = 25;
  double _opacity = 0.05;
  TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/jpg/woman.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
        child: Container(
          color: Theme.of(context).focusColor.withOpacity(_opacity),
          child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: buildAppBar(context),
            body: buildBody(context),
          ),
        ),
      ),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          RichText(
            text: TextSpan(
              text: 'Любимые ',
              style: Theme.of(context).textTheme.headline1,
              children: <TextSpan>[
                TextSpan(
                  text: 'Треки',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          SearchBar(searchController: searchController),
          SizedBox(height: 30.0),
          Text(
            'Популярные Плейлисты',
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Icon(
        Icons.menu,
        color: Theme.of(context).focusColor,
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          alignment: Alignment.center,
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/jpg/girl.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
