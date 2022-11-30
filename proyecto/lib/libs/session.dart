import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  String session = "",
      name = "",
      surname = "",
      user = "",
      email = "",
      path_photo = "";

  Session(this.session, this.name, this.surname, this.user, this.email,
      this.path_photo);

  static json(Session data) {
    return jsonEncode(data);
  }

  static obtener() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user') ?? "[{}]";
    List items = await jsonDecode(json) ?? [];
    return items;
  }

  Map toJson() => {
        'session': this.session,
        'name': this.name,
        'surname': this.surname,
        'user': this.user,
        'email': this.email,
        'path_photo': this.path_photo
      };

  static add(datos) async {
    final prefs = await SharedPreferences.getInstance();
    String json = await jsonEncode([datos.toJson()]);
    prefs.setString('user', json);
    return;
  }

  static delete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', "[{}]");
    return;
  }
}
