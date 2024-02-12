import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notion_post/domain/tag/entity/tag.dart';

//import '../../../../domain/tag/entity/tag.dart';
import '../tag_usecase.dart';

/// 全タグを保持するプロバイダー
final tagProvider = FutureProvider.autoDispose<List<Tag>>(
  (ref) async => ref.watch(tagUsecaseProvider).fetchTags(),
);
