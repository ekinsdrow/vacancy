// ignore_for_file: overridden_fields

import 'package:vacancy/sources/i_source.dart';

class GeekjobSource extends ISource {
  GeekjobSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://geekjob.ru/vacancies?qs=flutter';

  @override
  String get name => 'Geekjob';

  @override
  final isNeedFetch = false;

  @override
  Future<void> parseImplementation(String html) async {
    printSorry();
  }
}
