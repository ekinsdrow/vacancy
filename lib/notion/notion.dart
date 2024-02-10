import 'package:dio/dio.dart';

class Notion {
  final Dio dio;
  final String pageId;

  Notion({
    required this.dio,
    required this.pageId,
  });

  Future<int?> update() async {
    final value = await _fetchCurrentValue();
    if (value == null) {
      return value;
    }
    
    final resValue = value + 1;
    await _updateValue(resValue);
    return resValue;
  }

  Future<int?> _fetchCurrentValue() async {
    final response = await dio.get(
      'https://api.notion.com/v1/pages/$pageId',
    );

    final json = response.data as Map<String, dynamic>;
    final value = json['properties']?['Current']?['number'] as int?;

    if (value != null) {
      return value;
    }

    return null;
  }

  Future<void> _updateValue(int value) async {
    await dio.patch(
      'https://api.notion.com/v1/pages/$pageId',
      data: {
        'properties': {
          'Current': {
            'number': value,
          },
        },
      },
    );
  }
}
