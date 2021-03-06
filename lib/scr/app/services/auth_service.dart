import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

Future<Dio> login(String phone, String password) async {
  var dio = Dio();
  var cookieJar = CookieJar();
  dio.interceptors.add(CookieManager(cookieJar));
  dio.options.followRedirects = true;

  Map<String, String> headers = HashMap();
  headers.addAll({
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Language': 'ru-ru,ru;q=0.8,en-us;q=0.5,en;q=0.3',
    'Accept-Encoding': 'gzip, deflate',
    'Connection': 'keep-alive',
    'DNT': '1',
  });

  String url = 'https://vk.com/';
  dio.options.headers = headers;
  cookieJar.loadForRequest(Uri.parse('https://login.vk.com/'));
  Response response = await dio.get(url);

  String remixstid = response.headers['set-cookie'].toString();
  remixstid = remixstid
      .substring(remixstid.indexOf('remixstid') + 'remixstid'.length + 1);
  remixstid = remixstid.substring(0, remixstid.indexOf(';'));

  String remixlgk = response.headers['set-cookie'].toString();
  remixlgk =
      remixlgk.substring(remixlgk.indexOf('remixlgk') + 'remixlgk'.length + 1);
  remixlgk = remixlgk.substring(0, remixlgk.indexOf(';'));

  String remixsid = response.headers['set-cookie'].toString();
  remixsid =
      remixsid.substring(remixsid.indexOf('remixsid') + 'remixsid'.length + 1);
  remixsid = remixsid.substring(0, remixsid.indexOf(';'));

  String remixusid = response.headers['set-cookie'].toString();
  remixusid = remixusid.substring(remixusid.indexOf('remixusid')+'remixusid'.length+1);
  remixusid=remixusid.substring(0,remixusid.indexOf(';'));

  String html = response.data;
  html = html.substring(html.indexOf('id="quick_login_form"'));
  html = html.substring(0, html.indexOf('</form>'));

  String start = 'action="', end = '"';
  String action = html.substring(html.indexOf(start) + start.length);
  html = action.substring(action.indexOf(end) + end.length);
  action = action.substring(0, action.indexOf(end));

  List<String> parts = html.split('<input type="');
  Map<String, String> forms = HashMap();
  parts.removeAt(0);
  String name, value;
  parts.forEach((e) {
    if (e.startsWith('hidden')) {
      start = 'name="';
      end = '"';
      name = e.substring(e.indexOf(start) + start.length);
      name = name.substring(0, name.indexOf(end));
      start = 'value="';
      value = e.substring(e.indexOf(start) + start.length);
      value = value.substring(0, value.indexOf(end));
      forms[name] = value;
    } else if (e.contains('name="')) {
      start = 'name="';
      end = '"';
      name = e.substring(e.indexOf(start) + start.length);
      name = name.substring(0, name.indexOf(end));
      if (name == 'email') {
        value = phone;
        forms[name] = value;
      } else if (name == 'pass') {
        value = password;
        forms[name] = value;
      } else
        print('No such constant!');
    }
  });

  forms['to'] = 'bG9naW4/bT0xJmVtYWlsPWFzJnRvPWFXNWtaWGd1Y0dodw--';

  var forms2 = FormData.fromMap(forms);
  response = await dio.post(
    'https://login.vk.com/',
    queryParameters: {'act': 'login'},
    data: forms2,
    options: Options(
      followRedirects: true,
      validateStatus: (status) {
        return status < 500;
      },
    ),
  );

  List<String> lst = [
    'remixbdr=0',
    'remixsid=$remixsid',
    'remixusid=$remixusid',
    'remixstid=$remixstid',
    'remixflash=0.0.0',
    'remixscreen_width=1920',
    'remixscreen_height=1080',
    'remixscreen_dpr=1',
    'remixscreen_depth=24',
    'remixscreen_orient=1',
    'remixscreen_winzoom=1',
    'remixseenads=0',
    'remixlang=0',
    'remixlhk=$remixlgk',
  ];

  response.headers.forEach((name, values) {
    if (name.contains('remixq')) {
      lst.add(name + '=' + values.join());
    }
  });

  dio.options.headers['cookie'] = lst.join('; ');

  String location = response.headers['location'].toString();
  int length = location.length - 1;
  location = location.substring(1, length);

  Map<String, String> queryParams = {};

  String tmp = location.substring(location.indexOf('?') + 1);
  location = location.substring(0, location.indexOf('?'));

  List<String> params = tmp.split('&');
  params.forEach((element) {
    List<String> kv = element.split('=');
    queryParams.putIfAbsent(kv[0], () => kv[1]);
  });

  queryParams['to'] = 'aW5kZXgucGhw';

  response = await dio.get(location, queryParameters: queryParams);
  print(response.data.toString().contains('LoginDone'));
  bool success = response.data.toString().contains('onLoginDone');
  if(success){
    print('Login DONE!');
    return dio;
  }
  print('Login FAILED!');
  return null;
}
