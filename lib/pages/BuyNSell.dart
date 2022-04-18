// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDetails {
  String? name;
  String? desc;
  String? price;
  String? img;

// added '?'

  ProductDetails({this.name, this.desc, this.price, this.img});
  // can also add 'required' keyword
}

class BuyNSell extends StatefulWidget {
  const BuyNSell({Key? key}) : super(key: key);

  @override
  State<BuyNSell> createState() => _BuyNSellState();
}

class _BuyNSellState extends State<BuyNSell> {
  late List data;
  List<dynamic> userSearchItems = [];

  Future<List> getdata() async {
    // var res;
    // res = await http.get("https://fakestoreapi.com/products");

    // var resBody = json.decode(res.body);
    // return data = resBody["results"];
    await FirebaseFirestore.instance
        .collection('userdata')
        .get()
        .then((QuerySnapshot productsData) {
      //userSearchItems = [];
      productsData.docs.forEach((element) {
        //print(element.get('myProducts'));
        userSearchItems.addAll(element.get('myProducts'));
        // _products.insert(0, Product(
        //     id: element.get('productId'),
        //     title: element.get('productTitle'),
        //     description: element.get('productDescription'),
        //     price: double.parse(element.get('price')),
        //     imageUrl: element.get('productImage'),
        //     brand: element.get('productBrand'),
        //     productCategoryName: element.get('productCategory'),
        //     quantity: int.parse(element.get('productQuality')),
        //     isFavourite: false,
        //     isPopular: true));
      });
    });
    print(userSearchItems[0]["product_desc"]);
    // CollectionReference _collectionRef =
    //     FirebaseFirestore.instance.collection('userdata');
    // QuerySnapshot querySnapshot = await _collectionRef.get();

    // // Get data from docs and convert map to List
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // allData.forEach((doc) {
    //   print(doc.get(''))

    //   // User user = new User.fromDocument(doc);
    //   // UserSearchItem searchItem = new UserSearchItem(user);
    // });
    // for (int i = 0; i < allData.length; i++) {
    //   var a = allData[i];
    //   print(a);
    // }
    // print(allData[0]);
    //data.addAll(json.decode(allData));
    var url = Uri.parse('https://fakestoreapi.com/products');
    var response = await http.get(url);
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    var resBody = json.decode(response.body);

    return data = userSearchItems;
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
                        print(snapshot.data!);
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
                                    image: NetworkImage(snapshot.data![i]
                                            ["product_image"]
                                        .toString()),
                                    fit: BoxFit.contain),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(75.0)),
                              ),
                            ),
                            title: Text(
                                snapshot.data![i]["product_name"].toString()),
                            subtitle: Text("Rs. " +
                                snapshot.data![i]["product_price"].toString()),
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
