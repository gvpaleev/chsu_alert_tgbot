import 'package:dotenv/dotenv.dart';
import 'package:televerse/televerse.dart';
import 'message_template.dart';
import 'my_session.dart';

final DotEnv env = DotEnv(includePlatformEnvironment: true)..load();
final Televerse bot = Bot<MySession>(env["BOT_TG_TOKEN"]!);
final Conversation conversation = Conversation(bot);

void main(List<String> args) {
  //install Selenium

  try {
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
