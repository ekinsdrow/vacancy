import 'package:vacancy/sources/i_source.dart';

class WellfoundSource extends ISource {
  WellfoundSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://wellfound.com/jobs';

  @override
  String get name => 'Wellfound';

  @override
  // ignore: overridden_fields
  final isNeedFetch = false;


  @override
  Future<void> parseImplementation(String html) async {
    printSorry();
  }
}
