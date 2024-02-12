import 'dart:io';

import 'package:notion_post/application/state/overlay_loading_provider.dart';
import 'package:notion_post/domain/app_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/tag/entity/tag.dart';
import '../../../domain/tag/tag_repository.dart';
import '../../../domain/post/entity/post.dart';
import '../run_usecase_mixin.dart';
import 'state/tag_provider.dart';

/// 投稿ユースケースプロバイダー
final tagUsecaseProvider = Provider<TagUsecase>(
  TagUsecase.new,
);

/// 投稿ユースケース
class TagUsecase with RunUsecaseMixin {
  TagUsecase(this._ref);

  final Ref _ref;
  //Todo: 有料無料でカウント数を変える
  final int count = 3;

  /// 別Providerに依存するものはここに定義して利用する
  TagRepository get _tagRepository => _ref.read(tagRepositoryProvider);
  //StorageService get _storageService => _ref.read(storageServiceProvider);
  StateController<bool> get _loadingController =>
      _ref.read(overlayLoadingProvider.notifier);
  void _invalidateTagsProvider() => _ref.invalidate(tagProvider);

  /// 新規投稿をする
  Future<void> addTag({
    required String? tagId,
    required String tagName,
    required String tagColor,
    required String tagOrder,
  }) async {
    // if (image == null) {
    //   throw const AppException('画像を選択してください');
    // }
    //if (post == null) {
    //  throw const AppException();
    //}
    await execute(
        loadingController: _loadingController,
        action: () async {
//          final imageUrl = await _storageService.uploadImage(image: image);
          await _tagRepository.register(
            tag: Tag(
              tagId: null,
              tagName: tagName,
              tagColor: tagColor,
              tagOrder: tagOrder,
            ),
          );
        });
    _invalidateTagsProvider();
  }

  /// 投稿の全件取得処理
  ///
  /// 取得後に作成日時が新しい順に並び替える
  Future<List<Tag>> fetchTags() async {
    final tags = await execute(action: () async {
      return await _tagRepository.fetchTags();
    });
    //Todo: ソートはしなくていいようにnotionから取得する
    //final sortedPosts = posts
    //  ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    //return sortedPosts;
    return tags;
  }
}
