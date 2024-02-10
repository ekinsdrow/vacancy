import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class HabrSource extends ISource {
  HabrSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url =>
      'https://career.habr.com/vacancies?q=flutter&sort=date&type=all';

  @override
  String get name => 'Habr';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final vacancies = doc.querySelectorAll('.vacancy-card__inner');

    for (final vacancy in vacancies) {
      final salary = vacancy.querySelector('.basic-salary')?.innerHtml;
      final company = vacancy.querySelector('.vacancy-card__company-title a')?.innerHtml;
      final link = vacancy.querySelector('a')?.attributes['href'];

      if (link != null) {
        isHaveNewVacancies = true;
        listOfVacancies ??= [];

        if (salary == null || salary.isEmpty) {
          listOfVacancies!.add('https://career.habr.com/$link - $company - no salary');
        } else {
          if (salary.contains('\$') || salary.contains('€')) {
            listOfVacancies!.add('https://career.habr.com/$link - $company - $salary');
          }
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
