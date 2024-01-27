import 'package:televerse/televerse.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:webdriver/sync_io.dart';

part 'my_session.g.dart';

@JsonSerializable()
class MySession extends Session {
  int? id;
  String? groupName;
  String? groupCode;

  MySession();

  @override
  Map<String, dynamic> toJson() => _$MySessionToJson(this);

  factory MySession.fromJson(Map<String, dynamic> json) =>
      _$MySessionFromJson(json);
}
