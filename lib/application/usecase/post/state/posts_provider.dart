import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/post/entity/post.dart';
import '../fetchposts_usecase.dart';

/// 全投稿を保持するプロバイダー
final postsProvider = FutureProvider.autoDispose<List<Post>>(
  (ref) async => ref.watch(fetchUsecaseProvider).fetchPosts(),
);
