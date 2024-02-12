// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Post {
  String? get postId => throw _privateConstructorUsedError;
  String get inputContents => throw _privateConstructorUsedError;
  String get inputSelectTag => throw _privateConstructorUsedError;
  String get inputFreeTag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String? postId,
      String inputContents,
      String inputSelectTag,
      String inputFreeTag});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? inputContents = null,
    Object? inputSelectTag = null,
    Object? inputFreeTag = null,
  }) {
    return _then(_value.copyWith(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      inputContents: null == inputContents
          ? _value.inputContents
          : inputContents // ignore: cast_nullable_to_non_nullable
              as String,
      inputSelectTag: null == inputSelectTag
          ? _value.inputSelectTag
          : inputSelectTag // ignore: cast_nullable_to_non_nullable
              as String,
      inputFreeTag: null == inputFreeTag
          ? _value.inputFreeTag
          : inputFreeTag // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? postId,
      String inputContents,
      String inputSelectTag,
      String inputFreeTag});
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? inputContents = null,
    Object? inputSelectTag = null,
    Object? inputFreeTag = null,
  }) {
    return _then(_$PostImpl(
      postId: freezed == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String?,
      inputContents: null == inputContents
          ? _value.inputContents
          : inputContents // ignore: cast_nullable_to_non_nullable
              as String,
      inputSelectTag: null == inputSelectTag
          ? _value.inputSelectTag
          : inputSelectTag // ignore: cast_nullable_to_non_nullable
              as String,
      inputFreeTag: null == inputFreeTag
          ? _value.inputFreeTag
          : inputFreeTag // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostImpl implements _Post {
  const _$PostImpl(
      {required this.postId,
      required this.inputContents,
      required this.inputSelectTag,
      required this.inputFreeTag});

  @override
  final String? postId;
  @override
  final String inputContents;
  @override
  final String inputSelectTag;
  @override
  final String inputFreeTag;

  @override
  String toString() {
    return 'Post(postId: $postId, inputContents: $inputContents, inputSelectTag: $inputSelectTag, inputFreeTag: $inputFreeTag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.inputContents, inputContents) ||
                other.inputContents == inputContents) &&
            (identical(other.inputSelectTag, inputSelectTag) ||
                other.inputSelectTag == inputSelectTag) &&
            (identical(other.inputFreeTag, inputFreeTag) ||
                other.inputFreeTag == inputFreeTag));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, postId, inputContents, inputSelectTag, inputFreeTag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);
}

abstract class _Post implements Post {
  const factory _Post(
      {required final String? postId,
      required final String inputContents,
      required final String inputSelectTag,
      required final String inputFreeTag}) = _$PostImpl;

  @override
  String? get postId;
  @override
  String get inputContents;
  @override
  String get inputSelectTag;
  @override
  String get inputFreeTag;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
