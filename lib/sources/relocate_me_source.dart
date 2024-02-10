import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class RelocateMeSource extends ISource {
  RelocateMeSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://relocate.me/search?query=flutter';

  @override
  String get name => 'Relocate Me';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final title = doc.querySelector('.search-page__title b');
    final countOfVacancies = int.tryParse(title?.innerHtml ?? '0');

    if (countOfVacancies != null && countOfVacancies > 0) {
      isHaveNewVacancies = true;
      printSuccessMessage();
    } else {
      printErrorMessage();
    }
  }
}
