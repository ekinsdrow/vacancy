import 'package:dio/dio.dart';

abstract class ISource {
  final Dio dio;

  bool isNeedToShare = false;

  ISource({required this.dio});

  Future<Response<dynamic>> fetch() async {
    return await dio.get(url);
  }

  Future<void> parseResponse() async {
    final request = await fetch();

    if (request.statusCode == 200) {
      print('🕺 Successfully get $name');

      await parseImplementation(request.data as String);
    } else {
      print('😢 Error when parse $name');
    }
  }

  void printSuccessMessage() {
    print('✅ Find some new vacancies on $name');
    print('🔗 $url\n');
    isNeedToShare = true;
  }

  void printErrorMessage() {
    print('❌ Not find any new vacancies on $name\n');
  }

  void printSorry() {
    print('🤷‍♂️ Sorry, but $name is not parsable now');
    print('🤷‍♂️ Please check it by yourself');
    isNeedToShare = true;
    print('🔗 $url\n');
  }

  void printListOfVacancies() {
    if (listOfVacancies != null) {
      print('📋 List of vacancies on $name:');
      for (int i = 0; i < listOfVacancies!.length; i++) {
        final vacancy = listOfVacancies![i];
        final isLast = i == listOfVacancies!.length - 1;
        print('🔗 $vacancy${isLast ? '\n' : ''}');
      }
    }
  }

  Future<void> parseImplementation(String html);
  String get url;
  bool get isHaveNewVacancies;
  List<String>? get listOfVacancies;
  String get name;
}
