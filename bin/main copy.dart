// import 'package:dotenv/dotenv.dart';

// import 'package:http/http.dart' as http;
// import 'domain/student.dart';
// import 'package:webdriver/async_io.dart';

// var env = DotEnv(includePlatformEnvironment: true)..load();

// void main(List<String> arguments) async {
//   final webDriver = await createDriver();

//   try {
//     await webDriver.get('https://example.com');

//     final title = await webDriver.title;
//     print('Title: $title');
//   } finally {
//     await webDriver.quit();
//   }
// }

// Future<WebDriver> createDriver() async {
//   final capabilities = Capabilities.chrome;
//   // ..goog:chromeOptions = {
//   //   'args': ['--headless'], // Опционально: запустить Chrome в режиме headless
//   // };

//   final webDriver = await WebDriver.createDriver(
//     desiredCapabilities: capabilities,
//   );

//   return webDriver;
// }

// Future<String> getUrlData() async {
//   String url = 'https://www.chsu.ru/raspisanie/cache/student.json';
//   var response = await http.get(Uri.parse(url));
//   // Получение кук из ответа
//   var __js_p_ = response.headers['set-cookie']! + ';';
//   print(__js_p_.split('=')[1].split(';')[0]);
//   List<String> cookiesValues = __js_p_.split('=')[1].split(';')[0].split(',');

//   int code = int.parse(cookiesValues[0]);
//   int age = int.parse(cookiesValues[1]);
//   int sec = int.parse(cookiesValues[2]);
//   int disable_utm = int.parse(cookiesValues[3]);
//   int jhash = _jhash(code);

//   String __jhash_ =
//       "__jhash_=${jhash};max-age=${age};${(sec != 0 ? "SameSite=None;Secure;" : "")}Path=/;";

//   String __jua_ =
//       '__jua_=Mozilla%2F5.0%20%28X11%3B%20Linux%20x86_64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F120.0.0.0%20Safari%2F537.36;';
//   // Отправка GET-запроса с предыдущими куками
//   var anotherResponse = await http.get(Uri.parse(url), headers: {
//     'Cookie': __jua_ + __js_p_ + __jhash_,
//   });

//   print(anotherResponse.body);

//   return anotherResponse.body;
// }

// int _jhash(int b) {
//   int x = 123456789;
//   int k = 0;
//   for (int i = 0; i < 1677696; i++) {
//     x = ((x + b) ^ (x + (x % 3) + (x % 17) + b) ^ i) % 16776960;
//     if (x % 117 == 0) {
//       k = (k + 1) % 1111;
//     }
//   }
//   return k;
// }
