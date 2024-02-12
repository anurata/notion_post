import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entity/tag.dart';

/// ユーザーリポジトリプロバイダー
/// アプリ起動時 or テスト時に本プロバイダーを override して使用してください
final tagRepositoryProvider = Provider<TagRepository>(
  // 初期値を UserRepositoryImpl にしてしまうと、
  // ドメイン層がインフラ層に依存してしまうことになるので、
  // どの層にも依存させないために未実装エラーを返却するようにしておく
  (_) => throw UnimplementedError(),
);

/// Tag テーブル 及び 認証 に関するリポジトリ
abstract interface class TagRepository {
  /// Tag テーブルへユーザーレコードを追加 または 更新
  Future<Tag> register({required Tag tag});

  /// Tag テーブル内のユーザーレコードを削除
  Future<void> delete({required String tagid});

  /// Tag テーブル内のタグレコードを取得
  Future<List<Tag>> fetchTags();
}
