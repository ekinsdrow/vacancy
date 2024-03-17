import 'package:vacancy/sources/i_source.dart';

class TabbySource extends ISource {
  TabbySource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://tabby.ai/en-AE/careers';

  @override
  // ignore: overridden_fields
  final isNeedFetch = false;

  @override
  Future<void> parseImplementation(String html) async {
    printSorry();
  }

  @override
  String get name => 'Tabby';
}
