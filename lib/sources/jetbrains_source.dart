
import 'package:vacancy/sources/i_source.dart';

class JetbrainsSource extends ISource {
  JetbrainsSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://www.jetbrains.com/careers/jobs/';

  @override
  String get name => 'JetBrains';

  @override
  final isNeedFetch = false;

  @override
  Future<void> parseImplementation(String html) async {
    printSorry();
  }
}
