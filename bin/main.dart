import 'dart:io';

import 'package:webdriver/sync_io.dart';

void main(List<String> args) {
  final driver = createDriver(
      uri: Uri.parse('http://localhost:9515'),
      spec: WebDriverSpec.Auto,
      desired: Capabilities.firefox);
  // Открытие веб-страницы
  driver.get('https://www.chsu.ru/raspisanie/cache/student.json');

  // Ожидание для примера (необязательно)
  sleep(Duration(seconds: 5));

  // Получение заголовка страницы
  final title = driver.title;
  print('Title: $title');

  driver.quit();
  print('s');
}
