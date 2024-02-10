import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:vacancy/logger/logger.dart';
import 'package:vacancy/vacancy.dart';

class TelegramBot {
  final String token;

  /// Ekinsdrow
  final myChatId = 401014677;

  TeleDart? teleDart;

  TelegramBot({
    required this.token,
  });

  Future<void> startBot() async {
    final username = (await Telegram(token).getMe()).username;
    teleDart = TeleDart(
      token,
      Event(username!),
    );

    teleDart?.start();

    teleDart?.onCommand('get').listen(
      (message) async {
        if (message.chat.id != myChatId) {
          return;
        }

        message.reply(
          '🔍 Fetching vacancies...',
        );

        await fetch();
        final logs = Logger.getMessages();

        for (final msg in logs) {
          message.reply(
            msg,
          );
        }
      },
    );
  }

  Future<void> sendMessage() async {
    if (teleDart == null) {
      return;
    }

    teleDart?.sendMessage(
      myChatId,
      '🔍 Fetching vacancies...',
    );

    await fetch();
    final logs = Logger.getMessages();

    for (final message in logs) {
      teleDart?.sendMessage(
        myChatId,
        message,
      );
    }
  }
}
