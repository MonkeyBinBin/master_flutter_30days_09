import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

void main() async {
  // simple json parsing
  String jsonData = '{"name": "John", "age": 30}';
  Map<String, dynamic> data = jsonDecode(jsonData);
  print(data['name']); // Output: John

  // json parsing with list
  var response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    var posts = (jsonDecode(response.body) as List)
        .map((data) => Post.fromJson(data))
        .toList();
    for (var post in posts) {
      print('Title: ${post.title}');
    }
  } else {
    print('Failed to load posts');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// fetch data from API, get the status code and response body
void fetchData() async {
  var response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  print(response.statusCode); // Output: 200
  print(response.body);
}

// handling response
void handleResponse() async {
  var response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  if (response.statusCode == 200) {
    print('Success');
  } else {
    print('Failed');
  }
}

// post request and send data
void postData() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  var response = await http.post(url, body: {
    'title': 'Flutter http guide',
    'body': 'A guide to using the http package in Flutter',
    'userId': '1'
  });
  print(response.statusCode); // Output: 201
  print(response.body);
}

// error handling
void errorHandling() async {
  try {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      print('GET request successful. Response: ${response.body}');
    } else {
      print('GET request failed. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// onError to handle error
void onErrorHandle() async {
  var response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    body: {
      'title': 'Flutter http guide',
      'body': 'A guide to using the http package in Flutter',
      'userId': '1'
    },
  ).onError((error, stackTrace) {
    print('An error occurred: $error');
    return Response('Failed to post data', 500);
  });
  if (response.statusCode == 200) {
    print('GET request successful. Response: ${response.body}');
  } else {
    print('GET request failed. Status code: ${response.statusCode}');
  }
}

// downloading raw bytes
void downloadBytes() async {
  var response =
      await http.readBytes(Uri.parse('https://example.com/image.jpg'));
  var filePath = '/path/to/image.jpg';
  await File(filePath).writeAsBytes(response);
  print('Image downloaded to $filePath');
}
