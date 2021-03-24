import 'dart:ui';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vkify/scr/app/models/song_model.dart';
import 'package:flutter_vkify/scr/app/services/auth_service.dart';
import 'package:flutter_vkify/scr/app/services/music_provider.dart';
import 'package:flutter_vkify/scr/ui/global/loading.dart';
import 'package:flutter_vkify/scr/ui/widgets/music_tile.dart';
import 'package:flutter_vkify/scr/ui/widgets/search_bar.dart';
import 'package:flutter_vkify/scr/ui/views/login/login_view.dart';
import 'package:flutter_vkify/scr/ui/global/next_page_route.dart';

class HomeView extends StatelessWidget {
  final double _sigmaX = 25;
  final double _sigmaY = 25;
  final double _opacity = 0.05;
  final TextEditingController searchController = TextEditingController();
  final StreamController<List<Song>> streamController =
      StreamController<List<Song>>();
  final ScrollController listController = ScrollController();
  final AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  List<Song> children = [];

  Future<void> initMusic() async {
    print('add to stream');
    MusicProvider.fetchMusic(controller: streamController);
  }

  @override
  Widget build(BuildContext context) {
    initMusic();
    print('build home');
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

  AppBar buildAppBar(BuildContext context) {
    print(VKClient.me.id);
    print(VKClient.me.profileImageUrl);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: 40.0),
        icon: Icon(Icons.sensor_door_outlined),
        onPressed: () {
          VKClient.cookieJar.deleteAll();
          Navigator.pushReplacement(
            context,
            NextPageRoute(nextPage: LoginView()),
          );
        },
      ),
      actions: [
        Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.only(right: 40.0),
          width: 50,
          height: 50,
          child: Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: VKClient.me.profileImageUrl != ''
                    ? NetworkImage(VKClient.me.profileImageUrl)
                    : AssetImage('assets/jpg/girl.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding buildBody(BuildContext context) {
    print('build body');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          RichText(
            text: TextSpan(
              text: 'Любимые ',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(fontWeight: FontWeight.normal),
              children: <TextSpan>[
                TextSpan(
                  text: 'Треки',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          SearchBar(searchController: searchController),
          SizedBox(height: 30.0),
          Row(
            children: [
              Text(
                'Моя Музыка',
                style: Theme.of(context).textTheme.headline2,
              ),
              Spacer(),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Theme.of(context).focusColor,
                ),
                onPressed: () {
                  initMusic();
                },
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<List<Song>>(
              stream: streamController.stream,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
                if (snapshot.hasError) {
                  print('loading error');
                  return Center(
                    child: Text('Ошибка загрузки'),
                  );
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Icon(Icons.hourglass_empty);
                      break;
                    case ConnectionState.waiting:
                      return Loading();
                      break;
                    case ConnectionState.active:
                      print('AAAAAAAAAAAAAAAAAAAAAA');
                      print('has data');
                      print(snapshot.data);
                      children = List.from(snapshot.data);
                      break;
                    case ConnectionState.done:
                      print('done');
                      break;
                  }
                }
                return ListView.builder(
                  shrinkWrap: true,
                  controller: listController,
                  itemCount: children.length + 1,
                  itemBuilder: (context, i) {
                    if (i < children.length)
                      return MusicTile(
                        song: children[i],
                        audioPlayer: audioPlayer,
                      );
                    else
                      return SizedBox(height: 30.0);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
