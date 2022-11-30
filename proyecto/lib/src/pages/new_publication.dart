import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../libs/http.dart';
import '../../libs/session.dart';

class PageNewPublication extends StatefulWidget {
  const PageNewPublication({super.key});

  @override
  State<PageNewPublication> createState() => _PageNewPublication();
}

class _PageNewPublication extends State<PageNewPublication> {
  TextEditingController _description = TextEditingController();
  File? image = null;
  final picket = ImagePicker();
  String message = "...";
  Future seleImagen(op) async {
    var file;
    if (op == 1) {
      file = await picket.pickImage(source: ImageSource.camera);
    } else {
      file = await picket.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (file != null) {
        image = File(file.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      labelText: "Ingrese una descripción",
                      contentPadding: EdgeInsets.only(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  maxLength: 255,
                  controller: _description,
                )),
            SizedBox(
              height: 15.0,
            ),
            // enviar al servidor web
            ElevatedButton(
                child: Text("Publicar"),
                onPressed: () async {
                  setState(() {
                    message = "";
                  });
                  _enviarform();
                }),
            SizedBox(
              height: 30.0,
            ),

            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
                child: Text("Seleccionar imagen"),
                onPressed: () async {
                  seleImagen(0);
                }),
            SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
                child: Text("Tomar una foto"),
                onPressed: () async {
                  seleImagen(1);
                }),
            message == "" ? CircularProgressIndicator() : Text(message),
            image == null ? Center() : Image.file(image!),
          ],
        ),
      ),
    );
  }

  void _enviarform() async {
    setState(() {
      message = "";
    });
    var json = await Session.obtener();
    var rs;
    if (image == null) {
      rs = await ManagerHttp.post("publication/create",
          {"session": json[0]['session'], "description": _description.text});
    } else {
      rs = new http.MultipartRequest(
          "POST", Uri.http("44.205.104.168", "raau/publication/create"));
      rs.fields['session'] = json[0]['session'];
      rs.fields['description'] = _description.text;
      rs.files.add(await http.MultipartFile.fromPath('package', image!.path));
      rs = await rs.send();
      rs = rs.body;
    }
    setState(() {
      message = rs.toString();
    });
  }
}
