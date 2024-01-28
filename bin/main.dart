import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:televerse/televerse.dart';
import 'package:webdriver/sync_io.dart';
import 'message_template.dart';
import 'my_session.dart';
import 'university.dart';

final DotEnv env = DotEnv(includePlatformEnvironment: true)..load();
final Televerse bot = Bot<MySession>(env["BOT_TG_TOKEN"]!);
final Conversation conversation = Conversation(bot);

void main(List<String> args) {
  //install Selenium
  final WebDriver driver = createDriver(
      uri: Uri.parse(env['WEBDRIVE_URL'] ?? ''),
      spec: WebDriverSpec.Auto,
      desired: {
        'browserName': 'firefox',
        "moz:firefoxOptions": {
          "args": ["--headless", "--no-sandbox", "--disable-dev-shm-usage"]
        }
      });

// {
//         "moz:firefoxOptions": {
//           "args": ["--headless", "--no-sandbox", "--disable-dev-shm-usage"]
//         }
//       }

  try {
    //install Session
    bot.initSession((id) {
      return Session.loadFromFile<MySession>((json) => MySession.fromJson(json),
              id: id) ??
          MySession();
    });

    // command
    bot.command('setGroup', (ctx) async {
      final sess = ctx.session as MySession;

      await ctx.reply(MessageTemplate.setGroup(), parseMode: ParseMode.html);

      while (true) {
        var usersIncomingMessage =
            await conversation.waitForTextMessage(chatId: ctx.id);
        sess.groupName = usersIncomingMessage.message.text ?? '-';
        sess.groupCode = await University.getGroupCode(sess.groupName!, driver);

        if (sess.groupCode != null) {
          sess.saveToFile();

          ctx.reply(MessageTemplate.setGroupSuccessfully(),
              parseMode: ParseMode.html);

          break;
        }
        ctx.reply(MessageTemplate.setGroupUnsuccessful(),
            parseMode: ParseMode.html);
      }
    });

    // command
    bot.command('getSchedule', (ctx) async {
      final sess = ctx.session as MySession;
      if (sess.groupCode == null) {
        ctx.reply(MessageTemplate.getScheduleError(),
            parseMode: ParseMode.html);
        return;
      }
      ctx.reply(
          MessageTemplate.getSchedule(
              (await University.getScheduleGroup(sess.groupCode!, driver))),
          parseMode: ParseMode.html);
    });

    bot.start((ctx) async {
      ctx.react("🎉", isBig: true);
      ctx.reply(MessageTemplate.wellcome(), parseMode: ParseMode.html);
    });

    print('the program is running');
  } catch (e) {
    print(e);
  } finally {
    // driver.quit();
  }
}
