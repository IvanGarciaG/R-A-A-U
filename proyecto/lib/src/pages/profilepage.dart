import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/libs/http.dart';

import '../../libs/session.dart';
import 'login_page.dart';

class profilepage extends StatelessWidget {
  const profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(
            future: obtenerSession(),
            builder: (context, AsyncSnapshot snapshot) {
              var session = snapshot.data[0];
              if (session.length <= 0) {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
                          imageUrl: session["path_photo"],
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.fill,
                          width: 150,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            radius: 12,
                            child: Icon(
                              Icons.edit,
                              size: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: ListTile(
                        title: Text(
                          session['name'] + " " + session['surname'],
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subtitle: Text(session['email']),
                      ),
                    ),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: StadiumBorder(),
                          side: BorderSide(
                            width: 2,
                            color: Colors.greenAccent,
                          ),
                        ),
                        onPressed: () async {
                          ManagerHttp.post("user/logout",
                              {'session': session['session'] ?? ''});
                          await Session.delete();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                        },
                        child: Text('Cerrar sesión')),
                  ],
                ),
              );
            }),
        const SizedBox(
          height: 8,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [],
          ),
        )
      ]),
    );
  }
}

obtenerSession() async {
  return await Session.obtener();
}
