import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notion_database_api.g.dart';

class NotionDatabaseApi {
  final _storage = const FlutterSecureStorage();
  static const databaseName = 'サンプル';
  Future<String?> searchDatabases() async {
    final apiKey = await _storage.read(key: 'access_token');
    final response = await http.post(
      Uri.parse('https://api.notion.com/v1/search'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'query': databaseName,
        'filter': {
          'property': 'object',
          'value': 'database',
        },
        'sort': {
          'direction': 'ascending',
          'timestamp': 'last_edited_time',
        },
      }),
    );

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        for (var result in results) {
          final titles = result['title'] as List<dynamic>;
          for (var title in titles) {
            if (title['text']['content'] == databaseName) {
              return result['id'].toString();
            }
          }
        }
      }
      return null;
    } else {
      throw Exception('Failed to search database: ${response.body}');
    }
  }

  Future<List<String>> insertTitle(
      {required String databaseId, required String title}) async {
    final apiKey = await _storage.read(key: 'access_token');
    final response = await http.post(
      Uri.parse('https://api.notion.com/v1/pages'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'parent': {
          "type": "database_id",
          "database_id": databaseId,
        },
        "properties": {
          //   'タイトル': {

          "名前": {
            'title': [
              {
                'text': {
                  // 'content': title,
                  'content': "テスト",
                },
              },
            ],
          },
          "タイトル": {
            'rich_text': [
              // {
              //   'text': {
              //     // 'content': title,
              //     'content': "テスト",
              //   },
              // },
              {
                "type": "text",
                "text": {"content": "This is an ", "link": null},
                "annotations": {
                  "bold": false,
                  "italic": false,
                  "strikethrough": false,
                  "underline": false,
                  "code": false,
                  "color": "default"
                },
                "plain_text": "This is an ",
                "href": null
              }
            ],
          },
        },
      }),
    );

    if (response.statusCode == 200) {
      return await fetchTitles(databaseId: databaseId);
    } else {
      throw Exception('Failed to search database: ${response.body}');
    }
  }

  Future<List<String>> fetchTitles({required String databaseId}) async {
    final apiKey = await _storage.read(key: 'access_token');
    final response = await http.post(
      Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        List<String> titles = [];
        for (var page in results) {
          var titleProperty =
              //    page['properties']['名前']['title'] as List<dynamic>;
              page['properties']['タイトル']['rich_text'] as List<dynamic>;
          // page['properties']['Name']['title'] as List<dynamic>;
          if (titleProperty.isNotEmpty) {
            titles.add(titleProperty[0]['text']['content'] as String);
          }
        }
        return titles;
      }
      return [];
    } else {
      throw Exception('Failed to search database: ${response.body}');
    }
  }
}

@riverpod
NotionDatabaseApi notionDatabaseApi(NotionDatabaseApiRef ref) {
  return NotionDatabaseApi();
}
