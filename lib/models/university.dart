import 'dart:convert';

import 'package:http/http.dart' as http;

class University {
  String name;
  String country;
  String webPage;

  University({
    required this.name,
    required this.country,
    required this.webPage,
  });

  static Future<List<University>> getData({
    String name = "",
    String country = "",
  }) async {
    Uri url = Uri.parse(
      "http://universities.hipolabs.com/search?name=$name&country=$country",
    );

    http.Response response = await http.get(url);

    List body = jsonDecode(response.body);

    List<University> universities = body.map((e) {
      return University(
        name: e["name"],
        country: e["country"],
        webPage: e["web_pages"].first,
      );
    }).toList();

    return universities;
  }
}
