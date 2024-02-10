import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class StreamSource extends ISource {
  StreamSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://getstream.io/team/#jobs';

  @override
  String get name => 'Stream.io';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final vacancies = doc.querySelectorAll('.JobList-module--row--a8751');

    for (final vacancy in vacancies) {
      final title = vacancy.querySelector('span')?.innerHtml;
      final link = vacancy.attributes['href'];

      if (title != null && link != null) {
        if (title.toLowerCase().contains('flutter')) {
          isHaveNewVacancies = true;
          listOfVacancies ??= [];
          listOfVacancies!.add('https://getstream.io/$link');
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
