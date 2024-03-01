import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class FinchTrade extends ISource {
  FinchTrade({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://finchtrade.com/about-us.html#positions';

  @override
  String get name => 'Finchtrade';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);

    final vacanciesList = doc.querySelector('#positions')?.nextElementSibling?.querySelectorAll('.t_shdw') ?? [];
    for (final vacancy in vacanciesList) {
      final link = vacancy.querySelector('a')?.attributes['href'];
      final name = vacancy.querySelector('h3')?.text;

      if (link != null && name != null) {
        listOfVacancies ??= [];
        listOfVacancies!.add('$name - https://finchtrade.com/$link');
      }
    }

    if (listOfVacancies != null) {
      printListOfVacancies();
    } else {
      printErrorMessage();
    }
  }
}
