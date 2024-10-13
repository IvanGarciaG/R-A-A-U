import 'dart:convert';
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
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      labelText: "Ingrese una descripción",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                  maxLength: 255,
                  controller: _description,
                )),
            SizedBox(
              height: 15.0,
            ),
            // enviar al servidor web
            message == "Publicando..."
                ? CircularProgressIndicator()
                : ElevatedButton(
                    child: Text("Publicar"),
                    onPressed: () async {
                      setState(() {
                        message = "";
                      });
                      _enviarform();
                    }),
            SizedBox(
              height: 20.0,
            ),
            Text(message),
            SizedBox(
              height: 15.0,
            ),
            message == "Publicando..."
                ? Text("")
                : ElevatedButton(
                    child: Text("Seleccionar imagen"),
                    onPressed: () async {
                      seleImagen(0);
                    }),
            SizedBox(
              height: 15.0,
            ),
            message == "Publicando..."
                ? Text("")
                : ElevatedButton(
                    child: Text("Tomar una foto"),
                    onPressed: () async {
                      seleImagen(1);
                    }),
            image == null
                ? Center()
                : Container(
                    child: Image.file(
                      image!,
                      fit: BoxFit.scaleDown,
                      height: MediaQuery.of(context).size.height * 0.50,
                    ),
                    height: MediaQuery.of(context).size.height * 0.50,
                  )
          ],
        ),
      ),
    );
  }

  void _enviarform() async {
    setState(() {
      message = "Publicando...";
    });
    var json = await Session.obtener();
    var rs;
    if (image == null) {
      rs = await ManagerHttp.post("publication/create",
          {"session": json[0]['session'], "description": _description.text});
    } else {
      try {
        var req = http.MultipartRequest(
            'POST', Uri.parse(ManagerHttp.url + "publication/create"));
        req.files.add(await http.MultipartFile.fromPath('file', image!.path));
        req.fields['session'] = json[0]['session'];
        req.fields['description'] = _description.text;
        var res = await http.Response.fromStream(await req.send());
        var pos_index = res.body.indexOf("{");
        rs = jsonDecode(res.body.substring(pos_index, res.body.length));
      } catch (error) {
        rs = null;
      }
    }
    setState(() {
      if (rs != null && rs['session']) {
        message = (rs['status'] ?? false)
            ? "Pulicado con exito!!!"
            : "Error en el servidor";
      } else {
        message = "Vuelve a iniciar sesión";
      }
      image = null;
      _description.text = "";
    });
  }
}
