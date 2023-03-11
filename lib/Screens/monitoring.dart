import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Monitoring extends StatefulWidget {
  const Monitoring({Key? key}) : super(key: key);

  @override
  State createState() => MonitoringState();
}

class MonitoringState extends State<Monitoring> {
  final StreamController _streamController = StreamController();
  late Timer _timer;

  Future getData() async {
    var url = 'http://192.168.36.6/symonic_app/api/status';
    http.Response response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);

    //Add your data to stream
    _streamController.add(data);
  }

  @override
  void initState() {
    getData();

    //Check the server every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => getData());

    super.initState();
  }

  @override
  void dispose() {
    //cancel the timer
    if (_timer.isActive) _timer.cancel();

    // ignore: unused_local_variable
    var dispose = super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'SYMONIC',
          ),
          centerTitle: true),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      //leading: Icon(Icons.music_note),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              flex: 5, // 20%
                              child: Text(snapshot.data[index]['nama'])),
                          Expanded(
                              flex: 2, // 60%
                              child: Text(snapshot.data[index]['value'])),
                          Expanded(
                              flex: 3, // 20%
                              child: Text(snapshot.data[index]['satuan']))
                        ],
                      ),
                    ),
                    elevation: 8,
                    shadowColor: Colors.green,
                    margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
                    color: int.parse(snapshot.data[index]['value']) >
                            int.parse(snapshot.data[index]['ambangbatas'])
                        ? Colors.red
                        : Colors.green,
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
