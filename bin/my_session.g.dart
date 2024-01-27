// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySession _$MySessionFromJson(Map<String, dynamic> json) => MySession()
  ..id = json['id'] as int?
  ..groupName = json['groupName'] as String?
  ..groupCode = json['groupCode'] as String?;

Map<String, dynamic> _$MySessionToJson(MySession instance) => <String, dynamic>{
      'id': instance.id,
      'groupName': instance.groupName,
      'groupCode': instance.groupCode,
    };
