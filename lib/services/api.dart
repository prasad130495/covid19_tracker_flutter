import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Post> fetchPost() async {
  final response = await http
      .get('https://api.covidtracking.com/v1/states/ca/20200501.json');

  if (response.statusCode == 200) {
    // If the server returns an OK response, then parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If the response was umexpected, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int date;
  final String state;
  final int positive;
  final int death;

  Post({this.date, this.state, this.positive, this.death});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      date: json['date'],
      state: json['state'],
      positive: json['positive'],
      death: json['death'],
    );
  }
}
