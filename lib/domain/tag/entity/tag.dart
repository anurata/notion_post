import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';

@freezed
class Tag with _$Tag {
  const factory Tag({
    required String? tagId,
    required String tagName,
    required String tagColor,
    required String tagOrder,
  }) = _Tag;
}
