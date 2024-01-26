import 'package:dio/dio.dart';
import 'package:dotenv/dotenv.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;

class Student {
  late String groupName;
  late String groupCode;

  // @override
  // Future getScheduleForToday() {
  //   // TODO: implement getScheduleForToday
  //   throw UnimplementedError();
  // }

  Future setGroup(String group) async {
    var env = DotEnv(includePlatformEnvironment: true)..load();
    String url =
        '${env['GROUPS_CHSU_URL']!}?${DateTime.now().millisecondsSinceEpoch}=';

    // var cookieJar = CookieJar();

    // Создаем Dio с CookieManager
    // var dio = Dio();
    // dio.interceptors.add(CookieManager(cookieJar));

    try {
      var response = await http.get(Uri.parse(url));
      // Получение кук из ответа
      var cookies = response.headers['set-cookie'];
      print(cookies!.split('=')[1].split(';')[0]);
      List<String> cookiesValues =
          cookies.split('=')[1].split(';')[0].split(',');

      int code = int.parse(cookiesValues[0]);
      int age = int.parse(cookiesValues[1]);
      int sec = int.parse(cookiesValues[2]);
      int disable_utm = int.parse(cookiesValues[3]);
      int jhash = _jhash(code);

      String cookies2 =
          "__jhash_=${jhash};max-age=${age};${(sec != 0 ? "SameSite=None;Secure;" : "")}Path=/;";
      // Отправка GET-запроса с предыдущими куками
      var anotherResponse = await http.get(Uri.parse(url), headers: {
        'Cookie':
            '__jua_=Mozilla%2F5.0%20%28X11%3B%20Linux%20x86_64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F120.0.0.0%20Safari%2F537.36; __js_p_=219,900,0,0,0; __jhash_=863; __hash_=f038244a51a20188d76a45abfba2ced3; __lhash_=74707fd509e58ac79937f14ce716461f' //cookies + ';' + cookies2,
      });

      print(anotherResponse.body);
      // await dio.get(url);
      // // Print cookies
      // print(await cookieJar.loadForRequest(Uri.parse("https://dart.dev")));
      // // Second request with the cookies
      // await dio.get('https://dart.dev');

      // Выполняем GET-запрос
      // var response = await dio.get(url);

      // // Печать ответа
      // print(response.data);

      // // Ваши cookies теперь хранятся в cookieJar
      // // Можете получить их следующим образом
      // var storedCookies = cookieJar.loadForRequest(Uri.parse(url));
      // print('Stored Cookies: $storedCookies');
    } catch (e, s) {
      print('Error: $e');
      print('Stack: $s');
    }

    // final dio = Dio();
    // final response = await dio.get(url);
    // print(response.data);
    // final response = await http.get(Uri.parse(url));

    // String cookie =
    //     (response.headers['set-cookie']!.split('=')[1].split(';')[0]);

    // List<String> cookiesValues = cookie.split(',');

    // int code = int.parse(cookiesValues[0]);
    // int age = int.parse(cookiesValues[1]);
    // int sec = int.parse(cookiesValues[2]);
    // int disable_utm = int.parse(cookiesValues[3]);
    // int jhash = _jhash(code);

    // final response2 = await http.get(Uri.parse(url), headers: {
    //   'Cookie':
    //       '__jhash_=${jhash}; max-age=${age};${sec > 0 ? "SameSite=None;Secure;" : ""} Path=/"'
    // });
    // // document.cookie = "__jhash_=" + jhash + ";max-age=" + age + "; " + (sec ? "SameSite=None;Secure;" : "") + " Path=/";
    // // document.cookie = "__jua_=" + fixedEncodeURIComponent(navigator.userAgent) + ";max-age=" + age + "; " + (sec ? "SameSite=None;Secure;" : "") + " Path=/";
    // if (response.statusCode == 200) {
    //   print('Response data: ${response.body}');
    // } else {
    //   print('Request failed with status: ${response.statusCode}');
    // }

    // return response;
    // TODO: implement setGroup
  }

  int _jhash(int b) {
    int x = 123456789;
    int k = 0;
    for (int i = 0; i < 1677696; i++) {
      x = ((x + b) ^ (x + (x % 3) + (x % 17) + b) ^ i) % 16776960;
      if (x % 117 == 0) {
        k = (k + 1) % 1111;
      }
    }
    return k;
  }

  String getUrlData() {
    return '';
  }
}
