import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:notion_sample/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notion_oauth_api.g.dart';

class NotionOauthApi {
  final _storage = const FlutterSecureStorage();

  Future<void> authenticate(String url) async {
    final code = Uri.parse(url).queryParameters['code'];
    if (code != null) {
      final accessToken = await _getAccessToken(code);
      await _storage.write(key: 'access_token', value: accessToken);
    } else {
      throw Exception('code is null');
    }
  }

  Future<String> _getAccessToken(String code) async {
    final String encoded = base64Encode(utf8
        .encode('${Env.notionOauthClientId}:${Env.notionOauthClientSecret}'));
    final response = await http.post(
      Uri.parse('https://api.notion.com/v1/oauth/token'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Basic $encoded',
      },
      body: jsonEncode({
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': 'https://taichiro-s.github.io/notion_sample/redirects',
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      await _storage.write(
          key: 'workspace_name',
          value: data['workspace_name'] != null
              ? data['workspace_name'].toString()
              : '');
      await _storage.write(
          key: 'workspace_icon',
          value: data['workspace_icon'] != null
              ? data['workspace_icon'].toString()
              : '');
      return data['access_token'].toString();
    } else {
      throw Exception('Failed to get access token: ${response.body}');
    }
  }
}

@riverpod
NotionOauthApi notionOauthApi(NotionOauthApiRef ref) {
  return NotionOauthApi();
}
