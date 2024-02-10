import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class WoltSource extends ISource {
  WoltSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://careers.wolt.com/en/jobs';

  @override
  String get name => 'Wolt';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final vacanciesList = doc.querySelectorAll('.block-content a');

    for (final vacancy in vacanciesList) {
      final title = vacancy.querySelector('div h3')?.innerHtml;

      if (title != null && title.toLowerCase().contains('flutter')) {
        isHaveNewVacancies = true;
        listOfVacancies ??= [];
        final link = vacancy.attributes['href'];

        if (link != null) {
          listOfVacancies!.add('https://careers.wolt.com/$link');
        }
      }
    }

    if (listOfVacancies != null) {
      printListOfVacancies();
    } else {
      printErrorMessage();
    }
  }
}
