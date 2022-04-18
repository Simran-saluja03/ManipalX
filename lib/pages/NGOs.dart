import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NGOs extends StatefulWidget {
  const NGOs({Key? key}) : super(key: key);

  @override
  State<NGOs> createState() => _NGOsState();
}

class _NGOsState extends State<NGOs> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('lib/assets/ngos.json'),
      builder: (context, snapshot) {
        // Decode the JSON
        var newData = json.decode(snapshot.data.toString());

        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.settings, color: Colors.pink),
                    title: Text('Rotaract Club'),
                    subtitle: Text('No work beneath us, no task beyond'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunch("mail")) {
                            await launch("mail");
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: 25,
                          child: Icon(
                            Icons.open_in_new,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunch("mail")) {
                            await launch("mail");
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: 25,
                          child: Image.asset("lib/assets/ig.png"),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            );
          },
          itemCount: newData == null ? 0 : newData.length,
        );
      },
    ));
  }
}
