import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> localFile([String filename = '/userData.txt']) async {
  final path = await _localPath + filename;
  return File(path);
}

Future<Map<String, String>> readFile() async {
  try {
    final file = await localFile();
    String str = await file.readAsString();
    return toMap(str);
  } catch (e) {
    print('read error');
    return {};
  }
}

Future<File> writeFile(String key, String value) async {
  final file = await localFile();
  return file.writeAsString('\n' + key + '=' + value);
}

Future<File> writeStringFile(String str) async {
  final file = await localFile();
  return file.writeAsString(str);
}

Map<String, String> toMap(String str) {
  List<String> lst = str.split('\n');
  Map<String, String> map = {};
  for (int i = 0; i < lst.length; i ++) {
    if (lst[i] != '') {
      String k ,v;
      k=lst[i].substring(0,lst[i].indexOf('='));
      v=lst[i].substring(lst[i].indexOf('=')+1);
      map[k]=v;
    }
  }
  return map;
}

String toString(Map<String, String> map) {
  List<String> keys = map.keys.toList();
  String str = keys[0] + '=' + map[keys[0]];
  for (int i = 1; i < keys.length; i++) {
    str += '\n' + keys[i] + '=' + map[keys[i]];
  }
  return str;
}

