import 'package:dio/dio.dart';
import 'auth_service.dart';

class MusicProvider {
  static Future<String> fetchMusic() async {
    Map<String, String> queryParams = {'section': 'all'};

    String uri='https://vk.com/audios'+VKClient.userID.toString();
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
      String loginData = response.data.toString();
      print(loginData.contains('audio_page_player_btn'));
      return loginData.contains('audio_page_player_btn').toString();
    }
    print(response.data);
    print('music fetch error');
    return 'music fetch error';
  }
}
