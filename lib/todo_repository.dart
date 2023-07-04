import 'package:make_source/todo_apiclient.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:make_source/todo_itemdetail_response.dart';

class TodoRepository {
  final TodoApiClient todoApiClient;

  TodoRepository({required this.todoApiClient});

  Future<TodoItemDetailResponse?> fetchItemList(int itemIdx) async {
    try {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/$itemIdx');

      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        return TodoItemDetailResponse.fromJson(response.body as Map<String, dynamic>);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('fetch item detail => $e');
    }

    return null;
  }
}
