import 'package:flutter/material.dart';
import 'package:flutter_icon_explorer/all_icons.dart';
import 'package:flutter_icon_explorer/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Icon Explorer',
        theme: AppTheme.themeData,
        home: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: MyHomePage(title: 'Icon Explorer'),
        ));
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
    print("buidling");
    List<Map> icons = filter(all_icons, searchTerm);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SearchField((v) => this.setState(() => this.searchTerm = v)),
                Expanded(child: IconGrid(icons))
              ],
            )));
  }
}

class SearchField extends StatelessWidget {
  final Function(String) onChange;
  SearchField(this.onChange);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: TextFormField(
          onChanged: (v) => onChange(v),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 16),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1.0, color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: Icon(Icons.search),
          ),
        ));
  }
}

class IconGrid extends StatelessWidget {
  final List<Map> icons;
  IconGrid(this.icons);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: icons.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int i) => GridTile(icons[i]),
    );
  }
}

class GridTile extends StatelessWidget {
  final Map icon;
  GridTile(this.icon) : super(key: Key(icon["name"]));

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(icon["icon"], size: 50),
      SelectableText(
        '${icon["name"]}',
        style: Theme.of(context).textTheme.bodyText1,
      )
    ]);
  }
}
