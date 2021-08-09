import 'dart:html';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:platform_detect/decorator.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:prestapwa/installed.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  decorateRootNodeWithPlatformClasses();
  String dd;
  dd = browser.name;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Surditor de Aves',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Surditor de Aves'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with AfterLayoutMixin<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _launchURL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RaisedButton(
        onPressed: () {
          //_launchURL();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Installed()),
          );
        },
        child: Text('Inicio Surtidora' + browser.name),
      ),
    );
  }

  void _launchURL() async =>
      await canLaunch('https://surtidoradeaves.tiendishops.com/')
          ? await launch('https://surtidoradeaves.tiendishops.com/',
              forceSafariVC: true,
              forceWebView: true,
              webOnlyWindowName: "_self")
          : throw 'Could not launch https://surtidoradeaves.tiendishops.com/';

  void isWeb() {
    if (!browser.isChrome &&
        !browser.isFirefox &&
        !browser.isInternetExplorer &&
        !browser.isSafari) {
      //window.navigator.
      //_launchURL();
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    isWeb();
  }
}
