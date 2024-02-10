import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class GoogleSource extends ISource {
  GoogleSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url =>
      'https://www.google.com/about/careers/applications/jobs/results/?q=flutter';

  @override
  String get name => 'Google';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final title = doc.querySelector('.SWhIm');
    final countOfVacancies = int.tryParse(title?.innerHtml ?? '0');

    if (countOfVacancies != null && countOfVacancies > 0) {
      isHaveNewVacancies = true;
      printSuccessMessage();
    } else {
      printErrorMessage();
    }
  }
}
