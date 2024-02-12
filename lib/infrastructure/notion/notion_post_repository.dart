import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notion_post/domain/post/entity/post.dart';
import 'package:notion_post/domain/post/post_repository.dart';

class NotionPostRepository implements PostRepository {
  final _storage = const FlutterSecureStorage();
  //TODO: DB情報は、設定からとってくるようにする
  static const databaseName = 'Page_DB';
  static const databaseId = 'Page_DB';

  //TODO: プロパティ情報は、設定からとってくるようにする
  String titleProperty = "名前";
  String selectTagProperty = "タグ";
  String freeTagProperty = "lifetag";

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

  @override
  Future<void> add({required Post post}) async {
    // TODO: implement add
    final apiKey = await _storage.read(key: 'access_token');
    String title = post.inputContents;
    String selectTag = post.inputSelectTag;
    String freeTag = post.inputFreeTag;

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
          titleProperty: {
            'title': [
              {
                'text': {
                  'content': title,
                  //'content': "テスト",
                },
              },
            ],
          },
          selectTagProperty: {
            "multi_select": [
              {"name": selectTag},
            ]
          },
          freeTagProperty: {
            "multi_select": [
              {"name": freeTag},
            ]
          }
        },
      }),
    );

    // if (response.statusCode == 200) {
    //   return await fetchPosts();
    // } else {
    //   throw Exception('Failed to search database: ${response.body}');
    // }

    throw UnimplementedError();
  }

  @override
  Future<Post> fetch({required String postId}) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> fetchPosts({
    required int count,
  }) async {
    // TODO: implement fetchAll
    final apiKey = await _storage.read(key: 'access_token');
    final response = await http.post(
        Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Notion-Version': '2022-06-28',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "page_size": 3,
        }));

    if (response.statusCode == 200) {
      final results = jsonDecode(response.body)['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        //List<String> titles = [];
        List<Post> posts = [];
        int count = 0;
        for (var page in results) {
          var titles =
              page['properties'][titleProperty]['title'] as List<dynamic>;

          if (titles.isNotEmpty &&
              titles[0]['text'] != null &&
              titles[0]['text']['content'] != null) {
            Post curPost = Post(
              postId: "3",
              inputContents: titles[0]['text']['content'] as String,
              inputSelectTag: "",
              inputFreeTag: "",
            );

            posts.add(curPost);
            count++;

            if (count >= count) {
              break; // 最初の10件を取得したらループを終了
            }
          }
        }
        return posts;
      }
      return [];
    } else {
      throw Exception('Failed to search database: ${response.body}');
    }
    //throw UnimplementedError();
  }
}
