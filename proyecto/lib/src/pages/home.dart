import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var message = null;
  final controller = ScrollController();
  final refresh_key = GlobalKey<RefreshIndicatorState>();
  List<dynamic> lista = [{}];
  var pag = 1;
  var new_publications = true;
  Future obtener() async {
    var json = await Session.obtener();
    json = json[0];
    if ((json['session'] ?? null) == null) {
      return null;
    } else {
      var rs = await ManagerHttp.post(
          'publications', {'session': json['session'], 'pag': pag.toString()});
      if (pag == 1) {
        lista.removeAt(0);
      }
      if (rs['session'] ?? false) {
        setState(() {
          pag++;
          new_publications = rs['publications'].length > 0;
          lista.addAll(rs['publications']);
        });
      } else {
        setState(() {
          message = "Vuelve a iniciar sesión";
        });
        setState(() {
          new_publications = false;
          lista.addAll([{}]);
        });
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    obtener();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        obtener();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        body: message != null
            ? Text(message)
            : RefreshIndicator(
                key: refresh_key,
                onRefresh: () async {
                  setState(() {
                    new_publications = true;
                    pag = 1;
                    lista = [{}];
                    obtener();
                  });
                },
                child: lista == [{}]
                    ? CircularProgressIndicator()
                    : ListView.builder(
                        controller: controller,
                        itemCount: lista.length + 1,
                        itemBuilder: (context, index) {
                          if (index >= lista.length) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Center(
                                child: (new_publications)
                                    ? CircularProgressIndicator()
                                    : Text("NO HAY MÁS PUBLICACIONES"),
                              ),
                            );
                          } else {
                            if (lista.length < 2) {
                              return Text("");
                            }
                            return Container(
                                margin: EdgeInsets.all(15),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: InkWell(
                                    //onTap: () => print("Hola"),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: lista[index]
                                                        ["path_user"]
                                                    .toString(),
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                fit: BoxFit.fill,
                                                width: 50,
                                              ),
                                              Text(
                                                lista[index]["name_user"]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                lista[index]["description"]
                                                    .toString(),
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
                                                ? Text(lista[index]
                                                        ["path_media"]
                                                    .toString())
                                                : lista[index]["path_media"] ==
                                                        null
                                                    ? Text("")
                                                    : Container(
                                                        height: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.50,
                                                        child:
                                                            CachedNetworkImage(
                                                                imageUrl: lista[index]["path_media"]
                                                                    .toString(),
                                                                placeholder:
                                                                    (context, url) =>
                                                                        Container(
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.65,
                                                                          child:
                                                                              LinearProgressIndicator(
                                                                            minHeight:
                                                                                5,
                                                                            color:
                                                                                Colors.grey.shade700,
                                                                            backgroundColor:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                errorWidget:
                                                                    (context, url, error) =>
                                                                        Icon(Icons.error),
                                                                fit: BoxFit.scaleDown)),
                                          ),
                                        ]),
                                  ),
                                ));
                          }
                        },
                      )));
  }
}
