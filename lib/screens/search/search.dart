import 'package:flutter/material.dart';
import 'package:super_search/screens/search/tile.dart';
import 'package:super_search/style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<String>? _results;
  String _input = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Search Users"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
                style: Theme.of(context).textTheme.bodyText1,
                onChanged: _onSearchFieldChanged,
                autocorrect: false,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: placeholderTextFieldStyle,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                )),
          ),
          Expanded(
            child: (_results ?? []).isNotEmpty
                ? GridView.count(
                    childAspectRatio: 1,
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(2.0),
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 1.0,
                    children: _results!.map((r) => Tile(r)).toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: _results == null
                        ? Container()
                        : Text(
                            "No result found for '$_input'",
                            style: Theme.of(context).textTheme.caption,
                          ),
                  ),
          ),
        ],
      ),
    );
  }

  _onSearchFieldChanged(String value) async {
    setState(() {
      _input = value;
      if (value.isEmpty) {
        _results = null;
      }
    });

    final results = await searchUsers(value);

    setState(() {
      _results = results;
    });
  }

  Future<List<String>> searchUsers(String name) async {
    final result = await Supabase.instance.client
        .from('names')
        .select('fname, lname')
        .textSearch('fts', "$name:*")
        .limit(100)
        .execute();

    if (result.status != 200) {
      print('error: ${result.status.toString()}');
      return [];
    }

    final List<String> names = [];
    for (var v in ((result.data ?? []) as List<dynamic>)) {
      names.add("${v['fname']} ${v['lname']}");
    }
    return names;
  }
}
