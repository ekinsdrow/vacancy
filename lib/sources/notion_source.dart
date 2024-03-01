import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class NotionSource extends ISource {
  NotionSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://www.notion.so/careers';

  @override
  String get name => 'Notion';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final h3Elements = doc.querySelectorAll('h3');
    final targetElement = h3Elements.where((e) => e.innerHtml == "Engineering");
    final vacanciesList = targetElement.first.parent?.nextElementSibling?.querySelectorAll('li') ?? [];
    for (final vacancy in vacanciesList) {
      final link = vacancy.querySelector('a')?.attributes['href'];
      final name = vacancy.querySelector('p')?.innerHtml;

      if (link != null && name != null) {
        listOfVacancies ??= [];
        listOfVacancies!.add('$name - $link');
      }
    }

    if (listOfVacancies != null) {
      printListOfVacancies();
    } else {
      printErrorMessage();
    }
  }
}
