import 'package:vacancy/sources/i_source.dart';

class LinkedinSource extends ISource {
  LinkedinSource({required super.dio});

  @override
  bool isHaveNewVacancies = false;

  @override
  List<String>? listOfVacancies;

  @override
  String get url => 'https://www.linkedin.com/jobs/search/?currentJobId=3826908711&distance=25.0&f_TPR=r86400&f_WT=2&geoId=92000000&keywords=%22flutter%22&origin=JOB_SEARCH_PAGE_JOB_FILTER&position=3&pageNum=0';

  @override
  String get name => 'Linkedin';

  @override
  Future<void> parseImplementation(String html) async {
    printSorry();
  }
}
