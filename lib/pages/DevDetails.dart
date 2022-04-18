import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevDetails extends StatelessWidget {
  final Color myColor = Color(0xff00bfa5);

  Container userInfo(String name, String ig, String linked, String mail) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await launch(linked);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 25,
                  child: Image.asset("lib/assets/linked.png"),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await launch(mail);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 25,
                  child: Image.asset("lib/assets/gmail.png"),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await launch(ig);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 25,
                  child: Image.asset("lib/assets/ig.png"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      title: Column(
        children: <Widget>[
          // Container(
          //   child: ClipOval(
          //     child: Image.asset(
          //       'assets/images/ik.jpeg',
          //       height: 125,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          //   decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       border: Border.all(color: Colors.black, width: 2.0)),
          // ),
          userInfo(
              "Yusuf Khan",
              "https://www.instagram.com/ysf_khn/",
              "https://www.linkedin.com/in/mohammad-yusuf-khan-4862511b2",
              "mailto:yusufmohd72@gmail.com"),
          userInfo(
              "Simran Saluja",
              "https://www.instagram.com/the_bunnay_life/",
              "https://www.linkedin.com/in/simran-saluja03/",
              "mailto:simransaluja03@gmail.com"),
          userInfo(
              "Krishna Chaitanya",
              "https://www.instagram.com/krishna_chaitanya1912/",
              "https://www.linkedin.com/in/krishna-chaitanya-b0315b22a",
              "mailto:krischai19@gmail.com"),
          userInfo(
              "Ishan Kumar",
              "https://www.instagram.com/in/ik159/",
              "https://www.linkedin.com/in/ik159/",
              "mailto:itsik159@gmail.com"),
        ],
      ),
    );
  }
}
