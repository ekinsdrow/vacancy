import 'package:vacancy/sources/i_source.dart';

class VGVSource extends ISource {
  VGVSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://verygood.ventures/careers';

  @override
  String get name => 'VGV';

  @override
  Future<void> parseImplementation(String html) async {
    printSorry();
  }
}
