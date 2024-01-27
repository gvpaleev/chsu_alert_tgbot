abstract class MessageTemplate {
  static String wellcome() {
    return '''<b>Алгоритм:</b>
1) Задать группу /setGroup
2) Получить расписание /getSchedule

<b>Контакт:</b>
@tochka567
''';
//     return '''<b>bold</b>, <strong>bold</strong>
// <i>italic</i>, <em>italic</em>
// <u>underline</u>, <ins>underline</ins>
// <s>strikethrough</s>, <strike>strikethrough</strike>, <del>strikethrough</del>
// <span class="tg-spoiler">spoiler</span>, <tg-spoiler>spoiler</tg-spoiler>
// <b>bold <i>italic bold <s>italic bold strikethrough <span class="tg-spoiler">italic bold strikethrough spoiler</span></s> <u>underline italic bold</u></i> bold</b>
// <a href="http://www.example.com/">inline URL</a>
// <a href="tg://user?id=123456789">inline mention of a user</a>
// <tg-emoji emoji-id="5368324170671202286">👍</tg-emoji>
// <code>inline fixed-width code</code>
// <pre>pre-formatted fixed-width code block</pre>
// <pre><code class="language-python">pre-formatted fixed-width code block written in the Python programming language</code></pre>
// <blockquote>Block quotation started\nBlock quotation continued\nThe last line of the block quotation</blockquote>''';
  }

  static String setGroup() {
    return '''<b>Код группы ?</b>
Например: 7МБ-01-1вп-23
''';
  }

  static String getSchedule(List<dynamic> schedule) {
    String msg = '';
    if (schedule.isNotEmpty) {
      for (int i = 0; i < schedule.length; i++) {
        List<String> elem = schedule[i].split(';');
        msg += '''<b>${elem[0]} ${elem[2]}</b>
- ${elem[1]}
- ${elem[3]}

''';
      }
    } else {
      msg = '''<b>Сегодня нет занятий!</b>''';
    }
    return msg;
  }

  static String getScheduleError() {
    return '<b>Нужно задать группу:</b> /setGroup';
  }

  static String setGroupSuccessfully() {
    return '''<b>Успешно!</b>
Расписание: /getSchedule''';
  }

  static String setGroupUnsuccessful() {
    return '''<b>Ошибка, код группы правильный ?</b>
Например: 1АПб-01-1оп-23
Без лишних символов, пробелов и т п.
Регистр не важен.

Попробуй еще раз.
''';
  }
}
