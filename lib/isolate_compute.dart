import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users {
  final String name;
  final String photo;

  Users({
    required this.name,
    required this.photo,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      photo: json['photo'],
    );
  }

  @override
  String toString() {
    return '{$name,$photo}';
  }
}

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }

  @override
  String toString() {
    return '{$albumId,$id,$title,$url,$thumbnailUrl}';
  }
}

// 응답 결과를 List<Photo>로 변환하는 함수.
List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

class IsolateCompute extends StatefulWidget {
  const IsolateCompute({super.key});

  @override
  State<IsolateCompute> createState() => _IsolateComputeState();
}

class _IsolateComputeState extends State<IsolateCompute> {
  final List<Users> _users = [];
  List<Photo> _photo = [];

  requestPhoto() async {
    _photo = await fetchPhotos();
    setState(() {});
  }

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    return compute(parsePhotos, response.body);
  }

  requestList() async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/dev-yakuza/users/master/api.json',
    );
    final response = await http.get(url);
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    final List<Users> pareseResponse = parsed.map<Users>((json) => Users.fromJson(json)).toList();

    setState(() {
      _users.clear();
      _users.addAll(pareseResponse);
    });

    print(_users);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Expanded(
              child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: ListView.builder(
                      itemCount: _photo.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 60,
                          child: Row(
                            children: [
                              Image.network(_photo[index].thumbnailUrl),
                              Expanded(
                                child: Wrap(
                                  children: [
                                    Text(_photo[index].title),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                      childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
                      mainAxisSpacing: 10, //수평 Padding
                      crossAxisSpacing: 10, //수직 Padding
                      children: List.generate(_users.length, (index) {
                        //item 의 반목문 항목 형성
                        return Container(
                          alignment: Alignment.center,
                          color: Colors.grey.withOpacity(0.3),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                _users[index].photo,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  color: Colors.black.withOpacity(0.8),
                                  child: Text(
                                    _users[index].name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          )),
          Container(
            height: 60,
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    requestList();
                    requestPhoto();
                  },
                  child: const Text('Press')),
            ),
          )
        ],
      )),
    );
  }
}
