import 'package:flutter/material.dart';
import 'package:proyecto/libs/http.dart';
import 'package:proyecto/libs/session.dart';
import 'package:proyecto/src/pages/home.dart';
import 'package:proyecto/src/pages/login_page.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:proyecto/src/pages/publication.dart';
import 'package:proyecto/src/pages/register.dart';

class formWidget {
// boton de registrar (crear cuenta)
  static Widget btn_register(Map<String, TextEditingController> controllers) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'Crear cuenta ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, elevation: 10),
          onPressed: () async {
            var rs = await ManagerHttp.post('user/register', {
              'name': controllers['name']!.text,
              'surname': controllers['surname']!.text,
              'user': controllers['user']!.text,
              'email': controllers['email']!.text,
              'password': controllers['password']!.text
            });
            Navigator.of(context).pop();
          });
    });
  }

  static Widget last_name(TextEditingController? _controller) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: 'Apellidos',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          onChanged: (value) {},
        ),
      );
    });
  }

// boton de registrar
  static Widget user(TextEditingController? _controller) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
              labelText: 'Nombre de usuario',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          onChanged: (value) {},
        ),
      );
    });
  }

// boton de registrar (name)
  static Widget name(TextEditingController? _controller) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          onChanged: (value) {},
        ),
      );
    });
  }

  //Boton de registar password
  static Widget password(TextEditingController? _controller) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecoration(
              labelText: 'Contraseña',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          onChanged: (value) {},
        ),
      );
    });
  }
// boton de registrar (crear cuenta)

// boton de login
  static Widget btn_page_login(Map<String, TextEditingController> controllers) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'Iniciar sesión',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          });
    });
  }

  // BOTONES DE  LOGIN //
  static Widget btn_login(Map<String, TextEditingController> controllers) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'Iniciar Sesion',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, elevation: 10),
          onPressed: () async {
            var rs = await ManagerHttp.post('user/login', {
              'user': controllers['user']!.text,
              'password': controllers['password']!.text
            });
            if (rs != null) {
              if (rs['status']) {
                var user = rs['user'];
                Session.add(new Session(
                    user['session'],
                    user['name'],
                    user['surname'],
                    user['user'],
                    user['email'],
                    user['path_photo']));
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => pagePublication(),
                ));
              }
            }
          });
    });
  }

  static Widget btn_pag_register(
      Map<String, TextEditingController> controllers) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text(
              'Crear cuenta',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PageRegister(),
            ));
          });
    });
  }

  static Widget email(TextEditingController? _controller) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              labelText: 'Correo electrónico',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          onChanged: (value) {},
        ),
      );
    });
  }
}
