import 'package:flutter/material.dart';
import 'package:flutter_icon_explorer/all_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icon Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Icon Explorer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchTerm;

  filter(List<Map> icons, String term) {
    if (term == null || term.isEmpty) {
      return icons;
    }

    return icons.where((element) => element["name"].contains(term)).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map> icons = filter(all_icons, searchTerm);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    onChanged: (v) => this.setState(() => this.searchTerm = v),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.0, color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: Icon(Icons.search),
                    ),
                  )),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 5,
                crossAxisSpacing: 4,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: icons.map((thing) {
                  return Column(children: [
                    Icon(thing["icon"], size: 50),
                    Text(
                      '${thing["name"]}',
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ]);
                }).toList(),
              ))
            ])));
  }
}
