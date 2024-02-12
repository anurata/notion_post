import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String? postId,
    required String inputContents,
    required String inputSelectTag,
    required String inputFreeTag,
  }) = _Post;
}

//https://github.com/nozomi-koborinai/flutter-layered-architecture/blob/main/lib/domain/post/entity/post.dart