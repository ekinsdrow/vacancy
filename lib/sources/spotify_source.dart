import 'package:html/parser.dart';
import 'package:vacancy/sources/i_source.dart';

class SpotifySource extends ISource {
  SpotifySource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://www.lifeatspotify.com/jobs?q=flutter';

  @override
  String get name => 'Spotify';

  @override
  Future<void> parseImplementation(String html) async {
    final doc = parse(html);
    final title = doc.querySelector('#search-view span');
    final countOfVacancies = int.tryParse(title?.innerHtml ?? '0');


    if (countOfVacancies != null && countOfVacancies > 0) {
      isHaveNewVacancies = true;
      printSuccessMessage();
    } else {
      printErrorMessage();
    }
  }
}
