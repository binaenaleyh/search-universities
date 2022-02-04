import 'package:flutter/material.dart';
import 'package:search_universities/models/university.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<University>? universities;
  bool boarding = true;

  updateData({String name = "", String country = ""}) {
    setState(() {
      universities = null;
      boarding = false;
    });

    University.getData(name: name, country: country).then((value) {
      setState(() {
        universities = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Universities"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration:
                        const InputDecoration(hintText: "Search by name"),
                    onChanged: (String value) {
                      if (value.length >= 3) {
                        updateData(name: value);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    decoration:
                        const InputDecoration(hintText: "Search by country"),
                    onChanged: (String value) {
                      if (value.length >= 3) {
                        updateData(country: value);
                      }
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: boarding
                  ? const Center(
                      child: Text("To get started, search by name or country."))
                  : universities == null
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          padding: const EdgeInsets.only(top: 20),
                          children: universities!.map((University university) {
                            return Card(
                              child: Column(
                                children: [
                                  Text(
                                    university.name,
                                    style: textTheme.headline6,
                                  ),
                                  Text(university.country),
                                  ElevatedButton(
                                    onPressed: () {
                                      launch(university.webPage);
                                    },
                                    child: const Text("Go To Website"),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
