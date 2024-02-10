import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class RemoteOkSource extends ISource {
  RemoteOkSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://remoteok.com/remote-flutter-jobs?order_by=date';

  @override
  String get name => 'remoteok';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final vacanciesList = doc.querySelectorAll('tbody tr');

    for (final vacancy in vacanciesList) {
      final link = vacancy.querySelector('a')?.attributes['href'];
      final date = vacancy.querySelector('.time time')?.innerHtml;

      if (link != null && date != null) {
        if (!date.contains('mo')) {
          isHaveNewVacancies = true;
          listOfVacancies ??= [];
          listOfVacancies!.add('https://remoteok.com$link');
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
