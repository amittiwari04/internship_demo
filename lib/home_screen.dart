import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internship_demo/modals/url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  bool _isLoading = true;
  void getData() async {
    final result = await http.get(Uri.parse(url));
    if (result.body.isNotEmpty) {
      data = json.decode(result.body);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Demo'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.builder(
                itemCount: data['clients'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(' ${data['clients'][index]["name"]}'),
                    subtitle: Text(' ${data['clients'][index]["company"]}'),
                  );
                },
              ),
            ),
    );
  }
}
