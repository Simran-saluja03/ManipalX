// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BuyNSell extends StatefulWidget {
  const BuyNSell({Key? key}) : super(key: key);

  @override
  State<BuyNSell> createState() => _BuyNSellState();
}

class _BuyNSellState extends State<BuyNSell> {
  late List data;
  Future<List> getdata() async {
    // var res;
    // res = await http.get("https://fakestoreapi.com/products");

    // var resBody = json.decode(res.body);
    // return data = resBody["results"];
    var url = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var resBody = json.decode(response.body);

    return data = resBody;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: FutureBuilder<List>(
          future: getdata(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              children = <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    "Items",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(20),
                            leading: Container(
                              width: 75.0,
                              height: 75.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data![i]["image"]),
                                    fit: BoxFit.contain),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(75.0)),
                              ),
                            ),
                            title: Text(snapshot.data![i]["title"]),
                            subtitle: Text(
                                "Rs. " + snapshot.data![i]["price"].toString()),
                            trailing: Icon(
                              Icons.open_in_new,
                              color: Colors.red,
                            ),
                            isThreeLine: true,
                          ),
                        );
                      }),
                ),
              ];
            } else if (snapshot.hasError) {
              children = <Widget>[
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Loading'),
                )
              ];
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          },
        ),
      ),
    );
  }
}
