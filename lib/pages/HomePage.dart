import 'package:flutter/material.dart';
import 'package:manipalx/main.dart';
import 'package:manipalx/pages/BuyNSell.dart';
import 'package:manipalx/pages/DevDetails.dart';
import 'package:manipalx/pages/Donations.dart';
import 'package:manipalx/pages/NGOs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double width, height;

  final myController = TextEditingController();
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.black,
          ),
          child: Drawer(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset('lib/assets/logo.png'),
                ),
                ListTile(
                  leading: Icon(Icons.home, color: Colors.red),
                  title:
                      Text('Home', style: TextStyle(color: Colors.grey[200])),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                ),
                Divider(
                  color: Colors.red,
                ),
                ListTile(
                  leading: Icon(
                    Icons.computer,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Team',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => DevDetails(),
                    );
                  },
                ),
                Divider(
                  color: Colors.red,
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DevDetails()),
                    );
                  },
                ),
                Divider(
                  color: Colors.red,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.grey[200]),
                  ),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyApp()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.red),
          elevation: 0,
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "ManipalX",
            style: TextStyle(color: Colors.red),
          ),
          // bottom: PreferredSize(
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //     child: TextFormField(
          //       controller: myController,
          //       onFieldSubmitted: (String str) {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => SearchResults(str)),
          //         );
          //       },
          //       style: TextStyle(color: Colors.white),
          //       decoration: InputDecoration(
          //         filled: true,
          //         fillColor: Colors.white.withOpacity(0.15),
          //         enabledBorder: UnderlineInputBorder(
          //             borderRadius: BorderRadius.circular(10),
          //             borderSide: BorderSide(color: Colors.white)),
          //         focusedBorder: UnderlineInputBorder(
          //             borderRadius: BorderRadius.circular(10),
          //             borderSide: BorderSide(color: Colors.white)),
          //         suffixIcon: IconButton(
          //           icon: Icon(
          //             Icons.search,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) =>
          //                     SearchResults(myController.text),
          //               ),
          //             );
          //           },
          //         ),
          //         hintText: 'Movies, TV Shows and more...',
          //         hintStyle: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   ),
          //   preferredSize: Size.fromHeight(70),
          // ),
        ),
        body: TabBarView(
          children: [
            BuyNSell(),
            Donations(),
            NGOs(),
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          height: 48,
          child: TabBar(
            tabs: [
              Tab(
                icon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[Color(0xff5f0a87), Color(0xffa4508b)],
                    ).createShader(bounds);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Column(
                      children: [
                        Icon(Icons.shopping_cart_outlined),
                        Text(
                          "Buy N Sell",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Tab(
                icon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[Color(0xff5f0a87), Color(0xffa4508b)],
                    ).createShader(bounds);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.clean_hands_outlined),
                        Text(
                          "Donations",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Tab(
                icon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: <Color>[Color(0xff5f0a87), Color(0xffa4508b)],
                    ).createShader(bounds);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Column(
                      children: [
                        Icon(Icons.home_outlined),
                        Text(
                          "NGOs",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
