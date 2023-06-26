import 'package:flutter/material.dart';
import 'package:make_source/model/usersmodel.dart';

class UsersData extends StatefulWidget {
  const UsersData({super.key});

  @override
  State<UsersData> createState() => _UsersDataState();
}

class _UsersDataState extends State<UsersData> {
  List<dynamic> jsonPosts = [
    {
      "userId": 1,
      "id": 1,
      "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
      "body":
          "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    },
    {
      "userId": 1,
      "id": 2,
      "title": "qui est esse",
      "body":
          "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: jsonPosts.length,
          itemBuilder: (context, index) {
            var user = UserModel.fromJson(jsonPosts[index]);
            return Column(
              children: [
                Container(
                  color: Colors.red,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(user.title),
                ),
                Container(
                  height: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
