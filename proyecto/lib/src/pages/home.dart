import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/libs/http.dart';
import 'package:proyecto/src/pages/register.dart';
import 'package:video_player/video_player.dart';

import '../../libs/session.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Future<dynamic> datos = obtener();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: datos,
        builder: (context, AsyncSnapshot snapshot) {
          var lista = snapshot.data;
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child:
                    Text("Error al obtener publicaciones, intente más tarde"));
          }
          return ListView.builder(
            itemCount: lista.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: EdgeInsets.all(15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: InkWell(
                      //onTap: () => print("Hola"),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      lista[index]["path_user"].toString(),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                  width: 50,
                                ),
                                Text(
                                  lista[index]["name_user"].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  lista[index]["time"].toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 14),
                                ),
                                Text(
                                  lista[index]["description"].toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              child: (lista[index]["type"]
                                          .toString()
                                          .split("/")[0] ==
                                      "video")
                                  ? Text(lista[index]["path_media"].toString())
                                  : CachedNetworkImage(
                                      imageUrl:
                                          lista[index]["path_media"].toString(),
                                      placeholder: (context, url) =>
                                          LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Text(lista[index]["path_media"]
                                              .toString()),
                                      fit: BoxFit.fill),
                            ),
                          ]),
                    ),
                  ));
            },
          );
        },
      ),
    );
  }

  static Future obtener() async {
    var json = await Session.obtener();
    json = json[0];
    if ((json['session'] ?? null) == null) {
      return null;
    } else {
      var rs =
          await ManagerHttp.post('publications', {'session': json['session']});
      return rs['publications'];
    }
  }
}
