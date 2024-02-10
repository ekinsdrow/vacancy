import 'package:vacancy/sources/i_source.dart';

class FlutterSource extends ISource {
  FlutterSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://docs.flutter.dev/jobs';

  @override
  String get name => 'Flutter';

  @override
  Future<void> parseImplementation(String html) async {
    final isEmpty =
        html.contains('The Flutter and Dart teams aren’t currently hiring.');

    if (!isEmpty) {
      isHaveNewVacancies = true;
      printSuccessMessage();
    } else {
      printErrorMessage();
    }
  }
}
