import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class SuperListSource extends ISource {
  SuperListSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://www.superlist.com/careers';

  @override
  String get name => 'Superlist';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final vacanciesLinks = doc.querySelectorAll('.w-dyn-items .w-dyn-item a');

    for (final link in vacanciesLinks) {
      final title = link.innerHtml;

      if (title.toLowerCase().contains('flutter')) {
        isHaveNewVacancies = true;
        listOfVacancies ??= [];
        final href = link.attributes['href'];

        if (href != null) {
          listOfVacancies!.add(href);
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
