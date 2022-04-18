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
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        width: 75.0,
                        height: 75.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  newData![index]["img"].toString()),
                              fit: BoxFit.contain),
                          borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        ),
                      ),
                      title: Text(newData![index]["name"].toString()),
                      subtitle: Text(newData![index]["desc"].toString()),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await launch(newData![index]["web"].toString());
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
                            await launch(newData![index]["ig"].toString());
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
              ),
            );
          },
          itemCount: newData == null ? 0 : newData.length,
        );
      },
    ));
  }
}
