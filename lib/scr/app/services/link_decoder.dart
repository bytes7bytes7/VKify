class LinkDecoder {
  String n =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMN0PQRSTUVWXYZO123456789+/=';
  int uid = 0;

  LinkDecoder(int userID) {
    if (userID < 1) throw Exception('Invalid uid!');
    uid = userID;
  }

  static List<int> sortObject(Map<int, int> e) {
    String getPrice(List<int> lst) {
      String a = lst[0].toString(), b = lst[1].toString();
      while (a.length < 3) a = '0' + a;
      while (b.length < 3) b = '0' + b;
      return a + b;
    }

    List<List<int>> items = [];
    e.forEach((key, value) {
      items.add([key, value]);
    });
    items.sort((a, b) => getPrice(a).compareTo(getPrice(b)));
    return List.generate(items.length, (i) => items[i][1]);
  }

  static String v(dynamic e) {
    e = List.from(e).reversed;
    String r = '';
    e.forEach((i) => r += i);
    return r;
  }

  String r(dynamic e, dynamic t) {
    e = List.from(e);
    String o = this.n * 2;
    int a = e.length;
    while (a != 0) {
      a -= 1;
      int i = o.indexOf(e[a]);
      if (-i - 1 != 0) {
        e[a] = o[i - t];
      }
    }
    String r = '';
    e.codeUnits.forEach((i) => r += i);
    return r;
  }

  String s(String e, int t) {
    int eLength = e.length;
    if (eLength != 0) {
      List<int> i = this.decodeS(e, t);
      int o = 1;
      List<String> eE = List.from(e.split(''));
      while (o < eLength) {
        List<List<String>> lst = this.splice(eE, i[eLength - 1 - o], 1, eE[o]);
        List<String> _ = lst[0];
        eE = lst[1];
        eE[o] = _[0];
        o += 1;
      }
      String r = '';
      eE.forEach((i) => r += i);
      e = r;
    }
    return e;
  }

  dynamic i(String e, String t) {
    try {
      return this.s(e, int.parse(t) ^ this.uid);
    } catch (e) {
      return e;
    }
  }

  static String x(dynamic e, dynamic t) {
    String data = '';
    t = t[0].codeUnitAt(0);
    e.forEach((i) {
      data += String.fromCharCode(i[0].codeUnitAt(0) ^ t);
    });
    return data;
  }

  List<List<String>> splice(dynamic a, int b, int c, String d) {
    if (b is List) {
      print('HERE');
      throw Exception("ERROR Inside LinkDecoder!!!!!!!!!!!");
      //return this.splice(a, b[0],b[1],c, d);
    }
    c += b;
    List<String> cash = List.from(a), tCash = List.from(a);
    a = a.sublist(b, c);

    List<String> dD = [];
    dD = List.from(d.split(''));

    tCash = cash.sublist(0, b);
    tCash.add(d);
    tCash.addAll(cash.sublist(c));
    cash = List.from(tCash);

    return [a, cash];
  }

  List<int> decodeS(String e, int t) {
    int eLength = e.length;
    Map<int, int> i = {};
    if (eLength != 0) {
      int o = eLength;
      t = t.abs();
      while (o != 0) {
        o -= 1;
        t = (eLength * (o + 1) ^ int.parse(t.toString()) + o) % eLength;
        i[o] = t;
      }
    }
    return sortObject(i);
  }

  String decodeR(String e) {
    if (e == '' || e == null || (e.length % 4) == 1) {
      //return false;
      return null;
    }
    int o = 0, a = 0, t = 0;
    String r = '';
    int eLength = e.length;
    while (a < eLength) {
      int i = this.n.indexOf(e[a]);
      if ((-i - 1) != 0) {
        t = 64 * t + i;
        o += 1;
        if ((o - 1) % 4 != 0) {
          String c = String.fromCharCode(255 & t >> (-2 * o & 6));
          if (c != '\x00') {
            r += c;
          }
        }
      }
      a += 1;
    }
    return r;
  }

  String decode(String url) {
    if (-url.indexOf('audio_api_unavailable') - 1 != 0) {
      List<String> t = url.split('?extra=')[1].split('#');
      dynamic n;
      if ('' == t[1])
        n = '';
      else
        n = this.decodeR(t[1]);
      String tT = this.decodeR(t[0]);
      if (!(n is String) || t == [] || t == null) return url;
      if (n != '' && n != null)
        n = n.split('\t');
      else
        n = [];
      int lenN = n.length;
      while (lenN != 0) {
        lenN -= 1;
        List<String> s = n[lenN].split('\x0b');
        List<List<String>> lst = this.splice(s, 0, 1, tT);
        List<String> a = lst[0];
        s = lst[1];
        dynamic _;
        if (a[0] == 'n')
          _ = n;
        else if (a[0] == 'uid')
          _ = uid;
        else if (a[0] == 'i') _ = i;
        if (_ == 0 || _ == null || _ == '' || s.length < 2) {
          return url;
        }
        tT = _(s[0], s[1]);
      }
      if (tT.substring(0, 4) == 'http') return tT;
    }
    return url;
  }
}
