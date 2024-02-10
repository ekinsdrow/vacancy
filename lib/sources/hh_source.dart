import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class HHSource extends ISource {
  HHSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url =>
      'https://skopin.hh.ru/search/vacancy?ored_clusters=true&text=flutter&order_by=salary_desc';

  @override
  String get name => 'HH';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final vacanciesList = doc.querySelectorAll('.vacancy-serp-item-body');

    for (final vacancy in vacanciesList) {
      final link = vacancy.querySelector('a')?.attributes['href'];
      final salary =
          vacancy.querySelector('.bloko-header-section-2')?.innerHtml;

      if (link != null && salary != null) {
        if (salary.contains('\$') || salary.contains('€')) {
          isHaveNewVacancies = true;
          listOfVacancies ??= [];
          listOfVacancies!.add('$link - $salary');
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
