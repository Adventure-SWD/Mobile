import 'package:flutter/material.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<StatefulWidget> createState()
    => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = ThemeData();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: const <Widget>[
                  ],
                );
              }, suggestionsBuilder:
              (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
        ),
      ),
    );
  }
}


