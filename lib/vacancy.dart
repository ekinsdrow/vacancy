import 'package:dio/dio.dart';
import 'package:vacancy/sources/flutter_source.dart';
import 'package:vacancy/sources/geekjob_source.dart';
import 'package:vacancy/sources/google_source.dart';
import 'package:vacancy/sources/habr_source.dart';
import 'package:vacancy/sources/hh_source.dart';
import 'package:vacancy/sources/ladybaord_source.dart';
import 'package:vacancy/sources/linkedin_source.dart';
import 'package:vacancy/sources/relocate_me_source.dart';
import 'package:vacancy/sources/remoteok_source.dart';
import 'package:vacancy/sources/remotive_source.dart';
import 'package:vacancy/sources/spotify_source.dart';
import 'package:vacancy/sources/stream_source.dart';
import 'package:vacancy/sources/superlist_source.dart';
import 'package:vacancy/sources/vgv_source.dart';
import 'package:vacancy/sources/wellfound_source.dart';
import 'package:vacancy/sources/wolt_source.dart';

Future<void> fetch() async {
  final dio = Dio();

  final listOfAllVacancies = <String>[];
  final listOfSites = <String>[];

  final sources = [
    LinkedinSource(dio: dio),
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

  print('🐭 List of all links:');
  for (var i = 0; i < listOfAllVacancies.length; i++) {
    final link = listOfAllVacancies[i];
    final isLast = i == listOfAllVacancies.length - 1;
    print('🔗 $link${isLast ? '\n' : ''}');
  }

  print('🦄 List of all sites:');
  for (final site in listOfSites) {
    print('🌐 $site');
  }
}
