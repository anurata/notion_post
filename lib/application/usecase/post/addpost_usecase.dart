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
final postUsecaseProvider = Provider<PostUsecase>(
  PostUsecase.new,
);

/// 投稿ユースケース
class PostUsecase with RunUsecaseMixin {
  PostUsecase(this._ref);

  final Ref _ref;
  //Todo: 有料無料でカウント数を変える
  //final int count = 3;

  /// 別Providerに依存するものはここに定義して利用する
  PostRepository get _postRepository => _ref.read(postRepositoryProvider);
  //StorageService get _storageService => _ref.read(storageServiceProvider);
  StateController<bool> get _loadingController =>
      _ref.read(overlayLoadingProvider.notifier);
  void _invalidatePostsProvider() => _ref.invalidate(postsProvider);

  /// 新規投稿をする
  Future<void> addPost({
    required Post? post,
    required String inputContents,
    required String inputSelectTag,
    required String inputFreeTag,
  }) async {
    // if (image == null) {
    //   throw const AppException('画像を選択してください');
    // }
    if (post == null) {
      throw const AppException();
    }
    await execute(
        loadingController: _loadingController,
        action: () async {
//          final imageUrl = await _storageService.uploadImage(image: image);
          await _postRepository.add(
            post: Post(
              postId: null,
              inputContents: inputContents,
              inputSelectTag: inputSelectTag,
              inputFreeTag: inputFreeTag,
            ),
          );
        });
    _invalidatePostsProvider();
  }

  /// 投稿の全件取得処理
  ///
  /// 取得後に作成日時が新しい順に並び替える
  // Future<List<Post>> fetchPosts() async {
  //   final posts = await execute(action: () async {
  //     return await _postRepository.fetchPosts(count: 3);
  //   });
  //   //Todo: ソートはしなくていいようにnotionから取得する
  //   //final sortedPosts = posts
  //   //  ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
  //   //return sortedPosts;
  //   return posts;
  // }
}
