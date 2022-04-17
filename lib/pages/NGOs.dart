import 'package:flutter/material.dart';

class NGOs extends StatefulWidget {
  const NGOs({Key? key}) : super(key: key);

  @override
  State<NGOs> createState() => _NGOsState();
}

class _NGOsState extends State<NGOs> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.hail_outlined,
            color: Colors.red,
            size: 100,
          ),
          Text("Coming Soon"),
        ],
      ),
    );
  }
}
