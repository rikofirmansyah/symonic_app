import 'package:flutter/material.dart';
import 'package:symonic_app/Screens/monitoring.dart';
import 'package:symonic_app/Screens/setting.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('http://192.168.36.6/symonic_app/kamera');

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar:
          AppBar(backgroundColor: Colors.blue, title: const Text("SYMONIC")),
      body: GridView.count(
        padding: const EdgeInsets.all(25),
        crossAxisCount: 2,
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Monitoring()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(
                      Icons.analytics_rounded,
                      size: 70,
                      color: Colors.blueAccent,
                    ),
                    Text("Monitoring",
                        style: TextStyle(fontSize: 17.0, color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8),
            child: Center(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: Colors.black),
              onPressed: _launchUrl,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(
                      Icons.ad_units_rounded,
                      size: 70,
                      color: Colors.blueAccent,
                    ),
                    Text("Kamera",
                        style: TextStyle(fontSize: 17.0, color: Colors.black)),
                  ],
                ),
              ),
            )),
          ),
          Card(
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Setting()));
              },
              splashColor: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(
                      Icons.new_releases,
                      size: 70,
                      color: Colors.blueAccent,
                    ),
                    Text("Setting", style: TextStyle(fontSize: 17.0)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
