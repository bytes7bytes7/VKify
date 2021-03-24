import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_vkify/scr/app/services/link_decoder.dart';
import 'package:flutter_vkify/scr/app/models/song_model.dart';
import 'auth_service.dart';

class MusicProvider {
  static Future<void> fetchMusic({StreamController controller}) async {
    print('CALL FETCH MUSIC FUNC');
    List<String> findSongId(String html) {
      List<String> audioIDs = [];
      String point =
          'CatalogBlock__itemsContainer audio_page__audio_rows_list _audio_page__audio_rows_list _audio_pl audio_w_covers CatalogBlock__itemsContainer--reorderable';
      html = html.substring(html.indexOf(point) + point.length);
      List<String> raw = [];
      point = 'data-audio="[';
      raw = html.split(point);
      raw.removeAt(0);
      raw.forEach((e) {
        String first, second, third;
        List<String> ids = e.substring(0, e.indexOf(']"')).split(',');
        first = ids[0];
        ids = ids[13].replaceAll('\\/', '/').replaceAll('//', '/').split('/');
        if (ids.length == 5) {
          second = ids[1];
          third = ids[3];
        } else if (ids.length == 6) {
          second = ids[2];
          third = ids[4];
        }

        if (ids.length == 5 || ids.length == 6)
          audioIDs.add(VKClient.me.id.toString() +
              '_' +
              first +
              '_' +
              second +
              '_' +
              third);
      });
      return audioIDs;
    }

    Map<String, String> queryParams = {'section': 'all'};

    String uri = 'https://vk.com/audios' + VKClient.me.id.toString();
    print(uri);

    Response response = await VKClient.dio.get(
      uri,
      queryParameters: queryParams,
      options: Options(
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      String html = response.data.toString();
      print(html.contains('audio_page_player_btn'));

      List<String> audioIDs = findSongId(html);
      String ids = audioIDs[0];
      for (int i = 1; i < ((audioIDs.length >9) ? 10 : audioIDs.length); i++) ids += ',' + audioIDs[i];

      Map<String, String> map = {
        'al': '1',
        'ids': ids,
      };

      var forms = FormData.fromMap(map);
      String urlPart = 'al_audio.php';
      Map<String, String> queryParams = {'act': 'reload_audio'};

      response = await VKClient.dio.post('https://vk.com/' + urlPart,
          queryParameters: queryParams, data: forms);

      List<List<String>> encodedUrls = [];
      List<dynamic> jsonDecoded;
      try {
        jsonDecoded=
            json.decode(response.data.toString().substring(4))['payload'][1][0];
      } catch (e) {
        print(e);
        return;
      }
      jsonDecoded.forEach((e) {
        encodedUrls.add([e[4], e[3], e[2], e[5].toString(), e[14]]);
      });

      List<Song> songs = [];
      print('length of encoded urls: ${encodedUrls.length}');

      for (var e in encodedUrls) {
        String filename = e[0] + ' - ' + e[1] + '.mp3';
        for (int i = filename.length - 1; i >= 0; i--) {
          if ('~#%&*{}\\:<>?/+|"'.contains(filename[i])) {
            List<String> letters = List.from(filename.split(''));
            letters[i] = '';
            filename = letters.join();
          }
        }
        String m3u8Url = LinkDecoder(VKClient.me.id).decode(e[2]);
        response = await VKClient.dio.get(m3u8Url);
        String data = response.data;

        String point = '#EXT-X-KEY:METHOD=AES-128,URI="';
        String musicLink = data.substring(data.indexOf(point) + point.length);
        musicLink = musicLink
            .substring(0, musicLink.indexOf('?'))
            .replaceAll('/key.pub', '.mp3');
        String urlPart = musicLink.substring(musicLink.lastIndexOf('/'));
        musicLink = musicLink.substring(0, musicLink.lastIndexOf('/'));
        musicLink = musicLink.substring(0, musicLink.lastIndexOf('/'));
        musicLink += urlPart;

        print('filename: $filename');
        // print(musicLink);
        // print('');

        String title, author;
        author = filename.substring(0, filename.indexOf(' -'));
        filename = filename.substring(filename.indexOf(' - ') + 3);
        title = filename.substring(0, filename.length - 4);

        print('add to songs');
        songs.add(Song(
          url: musicLink,
          title: title,
          author: author,
          seconds: int.parse(e[3]),
          songImageUrl: e[4],
          isAdded: true,
          isDownloaded: false,
          isLiked: false,
        ));
      }
      print('return songs');
      //return songs;
      controller.add(songs);
      return;
    }
    print(response.data);
    print('music fetch error');
  }
}
