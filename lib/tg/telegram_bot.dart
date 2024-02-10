import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:vacancy/logger/logger.dart';
import 'package:vacancy/notion/notion.dart';
import 'package:vacancy/vacancy.dart';

class TelegramBot {
  /// Ekinsdrow
  final myChatId = 401014677;
  final String token;
  final Notion notion;

  TeleDart? teleDart;

  TelegramBot({
    required this.token,
    required this.notion,
  });

  Future<void> startBot() async {
    final username = (await Telegram(token).getMe()).username;
    teleDart = TeleDart(
      token,
      Event(username!),
    );

    teleDart?.start();

    teleDart?.onCommand('get').listen(_get);
    teleDart?.onCommand('update').listen(_update);
  }

  Future<void> _get(TeleDartMessage message) async {
    if (message.chat.id != myChatId) {
      return;
    }

    try {
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
    } on Exception catch (e) {
      message.reply(
        '❌ Error: $e',
      );
    }
  }

  Future<void> _update(TeleDartMessage message) async {
    if (message.chat.id != myChatId) {
      return;
    }

    try {
      message.reply(
        '🐶 Start update statistics',
      );

      final value = await notion.update();

      if (value == null) {
        message.reply(
          '🦊❌ Error: value is null, statistics not updated',
        );
      } else {
        message.reply(
          '🦊 Statistics updated to $value',
        );
      }
    } on Exception catch (e) {
      message.reply(
        '❌ Error: $e',
      );
    }
  }

  Future<void> sendMessage() async {
    if (teleDart == null) {
      return;
    }

    try {
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
    } on Exception catch (e) {
      teleDart?.sendMessage(
        myChatId,
        '❌ Error: $e',
      );
    }
  }
}
