import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.dev')
abstract class Env {
  @EnviedField(varName: 'NOTION_OAUTH_CLIENT_ID')
  static const String notionOauthClientId = _Env.notionOauthClientId;
  @EnviedField(varName: 'NOTION_OAUTH_CLIENT_SECRET')
  static const String notionOauthClientSecret = _Env.notionOauthClientSecret;
  @EnviedField(varName: 'NOTION_OAUTH_URL')
  static const String notionOauthUrl = _Env.notionOauthUrl;
}
