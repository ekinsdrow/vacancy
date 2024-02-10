class Logger {
  static List<String> messages = [];

  static void log(String message) {
    messages.add(message);
    print(message);
  }

  static List<String> getMessages() {
    final msgs = messages.join('\n');

    /// separate messages by 4096 characters and spaces
    /// because telegram has a limit of 4096 characters per message
    final separatedMessages = _splitString(msgs);

    _clear();

    return separatedMessages;
  }

  static void _clear() {
    messages.clear();
  }

  static List<String> _splitString(String s, [int limit = 4096]) {
    final words = s.split('\n');
    final chunks = <String>[];
    var currentChunk = '';

    for (final word in words) {
      if (currentChunk.length + word.length > limit) {
        chunks.add(currentChunk);
        currentChunk = word;
      } else {
        currentChunk = currentChunk.isNotEmpty ? '$currentChunk\n$word' : word;
      }
    }

    chunks.add(currentChunk);
    return chunks;
  }
}
