import 'dart:io';

import 'package:notion_post/application/state/overlay_loading_provider.dart';
import 'package:notion_post/domain/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/post/entity/post.dart';
import '../../../domain/post/post_repository.dart';
import '../../../domain/tag/entity/tag.dart';
import '../run_usecase_mixin.dart';
import 'state/posts_provider.dart';

/// 投稿ユースケースプロバイダー
final fetchUsecaseProvider = Provider<FetchUsecase>(
  FetchUsecase.new,
);

/// 投稿ユースケース
class FetchUsecase with RunUsecaseMixin {
  FetchUsecase(this._ref);

  final Ref _ref;
  //Todo: 有料無料でカウント数を変える
  final int count = 3;

  /// 別Providerに依存するものはここに定義して利用する
  PostRepository get _PostRepository => _ref.read(postRepositoryProvider);
  //StorageService get _storageService => _ref.read(storageServiceProvider);
  StateController<bool> get _loadingController =>
      _ref.read(overlayLoadingProvider.notifier);
  void _invalidateFetchProvider() => _ref.invalidate(postsProvider);

  /// 投稿の全件取得処理
  ///
  /// 取得後に作成日時が新しい順に並び替える
  Future<List<Post>> fetchPosts() async {
    final posts = await execute(action: () async {
      return await _PostRepository.fetchPosts(count: count);
    });
    //Todo: ソートはしなくていいようにnotionから取得する
    //final sortedPosts = posts
    //  ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    //return sortedPosts;
    return posts;
  }
}
