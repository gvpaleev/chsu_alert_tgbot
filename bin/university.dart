import 'dart:convert';
import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:webdriver/sync_io.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();

abstract class University {
  static Future<String?> getGroupCode(String groupName, WebDriver driver,
      {int time = 15}) async {
    driver.get(env['GROUPS_CHSU_URL']!);
    await _clickElementByXpath(
        "//a[@id='rawdata-tab'][text()='Raw Data']", driver);

    String data = await _getDataElementByXpath("//pre[@class='data']", driver);

    Map<String, String> mappingGroup = Map.fromIterable(jsonDecode(data),
        key: (item) => item[1].toUpperCase(), value: (item) => item[0]);

    // print(driver.cookies.all);
    // var elems = driver.findElementByXpath('root');

    // print(driver.pageSource);
    return mappingGroup[groupName.toUpperCase()];
  }

  static Future<String?> getScheduleGroup(String groupCode, WebDriver driver,
      {int time = 15}) async {
    String date = '05.02.${DateTime.now().year}';
    //${DateTime.now().day.toString().padLeft(2, '0')}.${DateTime.now().month.toString().padLeft(2, '0')}
    String url = env['LESSONS_CHSU_URL']!
        .replaceAll('BASE64', base64.encoder.convert(utf8.encoder.convert(
            //1771305192146908767
            '["student","$groupCode",null,"$date","$date"]')));
    driver.get(url);
    await _clickElementByXpath(
        "//a[@id='rawdata-tab'][text()='Raw Data']", driver);

    String data = await _getDataElementByXpath("//pre[@class='data']", driver);
    var lessons = jsonDecode(data)[0][1][0][2];
    // Map<String, String> mappingGroup = Map.fromIterable(jsonDecode(data),
    //     key: (item) => item[1].toUpperCase(), value: (item) => item[0]);

    // print(driver.cookies.all);
    // var elems = driver.findElementByXpath('root');

    print(driver.pageSource);
    return lessons
        .map((elem) =>
            '${elem[0]};${elem[1]}.${elem[2]};${elem[4]};${elem[6][0]}')
        .toList()
        .join('\n');
  }

  static _clickElementByXpath(String xPath, WebDriver driver,
      [int count = 15]) async {
    if (count > 0) {
      try {
        driver.findElementByXpath(xPath).click();
        print('click $xPath');
      } catch (e) {
        await Future.delayed(Duration(seconds: 1));
        await _clickElementByXpath(xPath, driver, --count);
      }
    } else {
      throw '$xPath не найден';
    }
  }

  static _getDataElementByXpath(String xPath, WebDriver driver,
      [int count = 15]) async {
    if (count > 0) {
      try {
        return driver.findElementByXpath(xPath).text;
      } catch (e) {
        await Future.delayed(Duration(seconds: 1));
        return await _getDataElementByXpath(xPath, driver, --count);
      }
    } else {
      throw '$xPath не найден';
    }
  }
}
