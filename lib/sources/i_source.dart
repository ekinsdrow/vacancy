import 'package:dio/dio.dart';
import 'package:vacancy/logger/logger.dart';

abstract class ISource {
  final Dio dio;

  bool isNeedToShare = false;

  final isNeedFetch = true;

  ISource({required this.dio});

  Future<Response<dynamic>> fetch() async {
    return await dio.get(url);
  }

  Future<void> parseResponse() async {
    if (isNeedFetch) {
      try {
        final request = await fetch();

        if (request.statusCode == 200) {
          Logger.log('🕺 Successfully get $name');

          await parseImplementation(request.data as String);
        } else {
          Logger.log('😢 Error when parse $name\n');
        }
      } on Exception catch (e) {
        Logger.log('❌ Error when get $name - $e\n');
      }
    } else {
      await parseImplementation('');
    }
  }

  void printSuccessMessage() {
    Logger.log('✅ Find some new vacancies on $name');
    Logger.log('🔗 $url\n');
    isNeedToShare = true;
  }

  void printErrorMessage() {
    Logger.log('❌ Not find any new vacancies on $name\n');
  }

  void printSorry() {
    Logger.log('🤷‍♂️ Sorry, but $name is not parsable now');
    Logger.log('🤷‍♂️ Please check it by yourself');
    isNeedToShare = true;
    Logger.log('🔗 $url\n');
  }

  void printListOfVacancies() {
    if (listOfVacancies != null) {
      Logger.log('📋 List of vacancies on $name:');
      for (int i = 0; i < listOfVacancies!.length; i++) {
        final vacancy = listOfVacancies![i];
        final isLast = i == listOfVacancies!.length - 1;
        Logger.log('🔗 $vacancy${isLast ? '\n' : ''}');
      }
    }
  }

  Future<void> parseImplementation(String html);
  String get url;
  bool get isHaveNewVacancies;
  List<String>? get listOfVacancies;
  String get name;
}
