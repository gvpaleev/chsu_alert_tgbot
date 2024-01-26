import 'package:televerse/televerse.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:dotenv/dotenv.dart';
import 'package:webdriver/sync_io.dart';

part 'my_session.g.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();

@JsonSerializable()
class MySession extends Session {
  int? id;
  String? _groupName;
  String? _groupCode;

  static final driver = createDriver(
      uri: Uri.parse(env['WEBDRIVE_URL'] ?? ''),
      spec: WebDriverSpec.Auto,
      desired: Capabilities.firefox);

  MySession();

  @override
  Map<String, dynamic> toJson() => _$MySessionToJson(this);

  factory MySession.fromJson(Map<String, dynamic> json) =>
      _$MySessionFromJson(json);

  set groupName(String name) {
    _groupName = name;
    _updateGroupCode();
  }

  _updateGroupCode() {
    // driver.get(env['GROUPS_CHSU_URL'] ?? '');
  }
}
