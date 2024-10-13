import 'dart:convert';

import 'package:http/http.dart' as http;

class ManagerHttp {
  static String url = 'http://44.205.104.168/raau/';
  //static String url = 'http://192.168.10.176/raau/';
  static String key =
      "75e36d4ef6f1172c8a2c61a8792e57e957dee9a7d03db1ebe750c3a0bcd650ee";

  static const int GET = 0;
  static const int POST = 1;
  static const int PUT = 2;
  static const int DELETE = 3;

  static get(String route) {
    return ManagerHttp.request(
      ManagerHttp.GET,
      route,
      {},
    );
  }

  static post(String route, Map body) {
    return ManagerHttp.request(
      ManagerHttp.POST,
      route,
      body,
    );
  }

  static put(String route, Map body) {
    return ManagerHttp.request(
      ManagerHttp.PUT,
      route,
      body,
    );
  }

  static delete(String route, Map body) {
    return ManagerHttp.request(
      ManagerHttp.DELETE,
      route,
      body,
    );
  }

  static request(method, route, body) async {
    try {
      var res = null;
      switch (method) {
        case ManagerHttp.GET:
          {
            res = await http.get(Uri.parse(ManagerHttp.url + route),
                headers: {'key': ManagerHttp.key});
            break;
          }
        case ManagerHttp.POST:
          {
            res = await http.post(Uri.parse(ManagerHttp.url + route),
                headers: {'key': ManagerHttp.key}, body: body);
            break;
          }
        case ManagerHttp.PUT:
          {
            res = await http.put(Uri.parse(ManagerHttp.url + route),
                headers: {'key': ManagerHttp.key}, body: body);
            break;
          }
        case ManagerHttp.DELETE:
          {
            res = await http.delete(Uri.parse(ManagerHttp.url + route),
                headers: {'key': ManagerHttp.key}, body: body);
            break;
          }
      }
      if (res == null) {
        return null;
      }
      var pos_index = res.body.indexOf("{");
      var json = jsonDecode(res.body.substring(pos_index, res.body.length));
      return json;
    } catch (error) {
      return null;
    }
  }
}
