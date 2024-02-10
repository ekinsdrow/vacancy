import 'package:vacancy/sources/i_source.dart';

class GeekjobSource extends ISource {
  GeekjobSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://layboard.com/vakansii/search?q=flutter';

  @override
  String get name => 'Layboard';

  @override
  Future<void> parseImplementation(String html) async {
    printSorry();
  }
}
