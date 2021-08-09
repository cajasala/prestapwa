import 'package:flutter/material.dart';

class Installed extends StatefulWidget {
  const Installed({Key? key}) : super(key: key);

  @override
  _InstalledState createState() => _InstalledState();
}

class _InstalledState extends State<Installed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Hola Mundo"),
    );
  }
}
