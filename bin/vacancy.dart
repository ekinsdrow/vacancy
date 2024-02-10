import 'package:vacancy/vacancy.dart' as vacancy;

void main(List<String> arguments) async {
  final bot = await vacancy.startBot();
  vacancy.startTimer(bot);
}
