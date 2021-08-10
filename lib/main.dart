import 'dart:html';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:platform_detect/decorator.dart';
import 'package:platform_detect/platform_detect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:universal_html/js.dart" as js;
import 'package:flutter/foundation.dart' show kIsWeb;

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
  bool vlEsperar = true;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        //final _prefs = await SharedPreferences.getInstance();
        //final _isWebDialogShownKey = "is-web-dialog-shown";
        //final _isWebDialogShown = _prefs.getBool(_isWebDialogShownKey) ?? false;
        //if (!_isWebDialogShown) {
        final bool isDeferredNotNull =
            js.context.callMethod("isDeferredNotNull") as bool;

        if (isDeferredNotNull) {
          debugPrint(">>> Add to HomeScreen prompt is ready.");
          await showAddHomePageDialog(context);

          // _prefs.setBool(_isWebDialogShownKey, true);
        } else {
          debugPrint(">>> Add to HomeScreen prompt is not ready yet.");
          vlEsperar = false;
        }
        //}
      });
    }
  }

  Future<bool?> showAddHomePageDialog(BuildContext context) async {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Icon(
                  Icons.add_circle,
                  size: 70,
                  color: Theme.of(context).primaryColor,
                )),
                SizedBox(height: 20.0),
                Text(
                  'Instalar aplicación en tu celular?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Tendras un acceso directo a nuestra tienda',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          js.context.callMethod("presentAddToHome");
                          Navigator.pop(context, false);
                        },
                        child: Text("Si!")),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Text("Iniciando aplicación..."),
      ],
    ));
  }

  void _launchURL() async =>
      await canLaunch('https://surtidoradeaves.tiendishops.com/')
          ? await launch('https://surtidoradeaves.tiendishops.com/',
              forceSafariVC: true,
              forceWebView: true,
              webOnlyWindowName: "_self")
          : throw 'Could not launch https://surtidoradeaves.tiendishops.com/';

  void isWeb() async {
    if (vlEsperar == false) {
      _launchURL();
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    isWeb();
  }
}
