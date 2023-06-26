import 'package:json_annotation/json_annotation.dart';

part 'usersmodel.g.dart';

@JsonSerializable()
class UserModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  UserModel(
    this.userId,
    this.id,
    this.title,
    this.body,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return "Users id [${id}] title: $title";
  }
}
