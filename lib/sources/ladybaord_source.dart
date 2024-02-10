import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class LadybaordSource extends ISource {
  LadybaordSource({required super.dio});

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
    final doc = parse(html);
    final vacancies = doc.querySelectorAll('.vacancy-card ');

    for (final vacancy in vacancies) {
      // date like 13-09-2023
      final date = vacancy.querySelector('.vacancy-date')?.innerHtml;
      final link = vacancy.querySelector('a')?.attributes['href'];

      if (link != null && date != null) {
        isHaveNewVacancies = true;

        final now = DateTime.now();
        final currentYear = now.year;
        final currentMonth = now.month;

        final vacancyYear = int.parse(date.split('-')[2]);
        final vacancyMonth = int.parse(date.split('-')[1]);

        if (currentYear == vacancyYear && currentMonth == vacancyMonth) {
          listOfVacancies ??= [];
          listOfVacancies!.add('https://layboard.com$link');
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
