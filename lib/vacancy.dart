import 'dart:async';

import 'package:dio/dio.dart';
import 'package:vacancy/logger/logger.dart';
import 'package:vacancy/notion/notion.dart';
import 'package:vacancy/sources/finctrade_source.dart';
import 'package:vacancy/sources/flutter_source.dart';
import 'package:vacancy/sources/geekjob_source.dart';
import 'package:vacancy/sources/google_source.dart';
import 'package:vacancy/sources/habr_source.dart';
import 'package:vacancy/sources/hh_source.dart';
import 'package:vacancy/sources/jetbrains_source.dart';
import 'package:vacancy/sources/ladybaord_source.dart';
import 'package:vacancy/sources/linkedin_source.dart';
import 'package:vacancy/sources/notion_source.dart';
import 'package:vacancy/sources/relocate_me_source.dart';
import 'package:vacancy/sources/remoteok_source.dart';
import 'package:vacancy/sources/remotive_source.dart';
import 'package:vacancy/sources/spotify_source.dart';
import 'package:vacancy/sources/stream_source.dart';
import 'package:vacancy/sources/superlist_source.dart';
import 'package:vacancy/sources/vgv_source.dart';
import 'package:vacancy/sources/wellfound_source.dart';
import 'package:vacancy/sources/wolt_source.dart';
import 'package:vacancy/tg/telegram_bot.dart';

Future<TelegramBot> startBot() async {
  final bot = TelegramBot(
    token: '6902334626:AAHgRQi6KxP3zM50TE5-zroaQpg_R7j_gHs',
    notion: Notion(
      dio: Dio(
        BaseOptions(
          headers: {
            'Authorization': 'Bearer secret_kHkqpzmZCLdBaYAi2kWUf7PC0xmrSjHL8wmBwehqGZo',
            'Notion-Version': '2022-02-22',
          },
        ),
      ),
      pageId: '2d8c8da6212c4ee9a98dc834ca805300',
    ),
  );

  await bot.startBot();

  return bot;
}

Future<void> startTimer(TelegramBot bot) async {
  Timer.periodic(
    Duration(minutes: 1),
    (timer) {
      final now = DateTime.now();
      final currentHours = now.hour;
      final currentMinutes = now.minute;

      if (currentHours == 6 && currentMinutes == 0) {
        bot.sendMessage();
      }
    },
  );
}

Future<String> fetch() async {
  final dio = Dio();

  final listOfAllVacancies = <String>[];
  final listOfSites = <String>[];

  final sources = [
    FinchTrade(dio: dio),
    NotionSource(dio: dio),
    HHSource(dio: dio),
    RemoteOkSource(dio: dio),
    StreamSource(dio: dio),
    RelocateMeSource(dio: dio),
    WoltSource(dio: dio),
    SuperListSource(dio: dio),
    SpotifySource(dio: dio),
    GoogleSource(dio: dio),
    FlutterSource(dio: dio),
    HabrSource(dio: dio),
    LadybaordSource(dio: dio),

    // Without parsing
    GeekjobSource(dio: dio),
    JetbrainsSource(dio: dio),
    LinkedinSource(dio: dio),
    RemotiveSource(dio: dio),
    VGVSource(dio: dio),
    WellfoundSource(dio: dio),
  ];

  for (final source in sources) {
    await source.parseResponse();

    if (source.listOfVacancies != null) {
      listOfAllVacancies.addAll(source.listOfVacancies!);
    } else if (source.isNeedToShare) {
      listOfSites.add(source.url);
    }
  }

  Logger.log('🐭 List of all links:');
  for (var i = 0; i < listOfAllVacancies.length; i++) {
    final link = listOfAllVacancies[i];
    final isLast = i == listOfAllVacancies.length - 1;
    Logger.log('🔗 $link${isLast ? '\n' : ''}');
  }

  Logger.log('🦄 List of all sites:');
  for (final site in listOfSites) {
    Logger.log('🌐 $site');
  }

  final fullList = [
    ...listOfAllVacancies,
    ...listOfSites,
  ];

  return fullList.join('\n');
}
