import 'package:vacancy/sources/i_source.dart';

class RemotiveSource extends ISource {
  RemotiveSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://remotive.com/?query=flutter';

  @override
  String get name => 'Remotive';

  @override
  // ignore: overridden_fields
  final isNeedFetch = false;


  @override
  Future<void> parseImplementation(String html) async {
    printSorry();
  }
}
