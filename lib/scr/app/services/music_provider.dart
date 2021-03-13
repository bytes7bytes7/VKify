import 'dart:collection';
import 'package:dio/dio.dart';
import 'auth_service.dart';

class MusicProvider {
  static Future<String> fetchMusic() async {
    //Response response = VKClient.dio.get();
    Map<String, String> headers = HashMap();
    headers.addAll({
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
      'Accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
      'Accept-Language': 'ru-ru,ru;q=0.8,en-us;q=0.5,en;q=0.3',
      'Accept-Encoding': 'gzip, deflate',
      'Connection': 'keep-alive',
      'DNT': '1',
    });
    Map<String, String> queryParams = {'section': 'all'};

    Response response = await VKClient.dio.get(
      'https://vk.com/audios${VKClient.userID}',
      options: Options(
        validateStatus: (status) {
          return status < 500;
        },
      ),
    );

    if (response.statusCode == 200) {
      String loginData = response.data.toString();
      print(loginData.contains('audio_page_player_btn'));
      return 'ok';
    }
    print('error');
    return 'error';
  }
}
