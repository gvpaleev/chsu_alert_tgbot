import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:televerse/televerse.dart';
import 'package:webdriver/sync_io.dart';
import 'my_session.dart';

final env = DotEnv(includePlatformEnvironment: true)..load();
final bot = Bot<MySession>(env["BOT_TG_TOKEN"]!);

void main(List<String> args) {
  try {
    bot.initSession((id) {
      return Session.loadFromFile<MySession>((json) => MySession.fromJson(json),
              id: id) ??
          MySession();
    });

    bot.command('setGroup', (ctx) {
      ctx.reply('Напиши код группы!');
    });

    bot.command('getSchedule', (ctx) {
      ctx.reply('Твое расписание!');
    });

    bot.command('count', (ctx) {
      final sess = ctx.session as MySession;

      ctx.reply((ctx.session).toString());
      // ctx.reply((++sess.count).toString());
      sess.saveToFile();
    });

    bot.start((ctx) async {
      ctx.react("🎉", isBig: true);
      // ctx.myMethod()
    });

    print('good Main');
  } catch (e) {
    print(e);
  } finally {
    // driver.quit();
  }
}
