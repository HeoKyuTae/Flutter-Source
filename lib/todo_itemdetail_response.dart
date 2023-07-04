import 'package:json_annotation/json_annotation.dart';

part 'todo_itemdetail_response.g.dart';

@JsonSerializable()
class TodoItemDetailResponse {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoItemDetailResponse(
    this.userId,
    this.id,
    this.title,
    this.completed,
  );

  factory TodoItemDetailResponse.fromJson(Map<String, dynamic> json) => _$TodoItemDetailResponseFromJson(json);
}
