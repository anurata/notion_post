// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notion_database_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NotionDatabaseState {
  AsyncValue<List<String>> get titles => throw _privateConstructorUsedError;
  String get newTitle => throw _privateConstructorUsedError;
  bool get isInputting => throw _privateConstructorUsedError;
  bool get isInserting => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NotionDatabaseStateCopyWith<NotionDatabaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotionDatabaseStateCopyWith<$Res> {
  factory $NotionDatabaseStateCopyWith(
          NotionDatabaseState value, $Res Function(NotionDatabaseState) then) =
      _$NotionDatabaseStateCopyWithImpl<$Res, NotionDatabaseState>;
  @useResult
  $Res call(
      {AsyncValue<List<String>> titles,
      String newTitle,
      bool isInputting,
      bool isInserting});
}

/// @nodoc
class _$NotionDatabaseStateCopyWithImpl<$Res, $Val extends NotionDatabaseState>
    implements $NotionDatabaseStateCopyWith<$Res> {
  _$NotionDatabaseStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titles = null,
    Object? newTitle = null,
    Object? isInputting = null,
    Object? isInserting = null,
  }) {
    return _then(_value.copyWith(
      titles: null == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<String>>,
      newTitle: null == newTitle
          ? _value.newTitle
          : newTitle // ignore: cast_nullable_to_non_nullable
              as String,
      isInputting: null == isInputting
          ? _value.isInputting
          : isInputting // ignore: cast_nullable_to_non_nullable
              as bool,
      isInserting: null == isInserting
          ? _value.isInserting
          : isInserting // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotionDatabaseStateImplCopyWith<$Res>
    implements $NotionDatabaseStateCopyWith<$Res> {
  factory _$$NotionDatabaseStateImplCopyWith(_$NotionDatabaseStateImpl value,
          $Res Function(_$NotionDatabaseStateImpl) then) =
      __$$NotionDatabaseStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AsyncValue<List<String>> titles,
      String newTitle,
      bool isInputting,
      bool isInserting});
}

/// @nodoc
class __$$NotionDatabaseStateImplCopyWithImpl<$Res>
    extends _$NotionDatabaseStateCopyWithImpl<$Res, _$NotionDatabaseStateImpl>
    implements _$$NotionDatabaseStateImplCopyWith<$Res> {
  __$$NotionDatabaseStateImplCopyWithImpl(_$NotionDatabaseStateImpl _value,
      $Res Function(_$NotionDatabaseStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? titles = null,
    Object? newTitle = null,
    Object? isInputting = null,
    Object? isInserting = null,
  }) {
    return _then(_$NotionDatabaseStateImpl(
      titles: null == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as AsyncValue<List<String>>,
      newTitle: null == newTitle
          ? _value.newTitle
          : newTitle // ignore: cast_nullable_to_non_nullable
              as String,
      isInputting: null == isInputting
          ? _value.isInputting
          : isInputting // ignore: cast_nullable_to_non_nullable
              as bool,
      isInserting: null == isInserting
          ? _value.isInserting
          : isInserting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NotionDatabaseStateImpl implements _NotionDatabaseState {
  const _$NotionDatabaseStateImpl(
      {required this.titles,
      required this.newTitle,
      required this.isInputting,
      required this.isInserting});

  @override
  final AsyncValue<List<String>> titles;
  @override
  final String newTitle;
  @override
  final bool isInputting;
  @override
  final bool isInserting;

  @override
  String toString() {
    return 'NotionDatabaseState(titles: $titles, newTitle: $newTitle, isInputting: $isInputting, isInserting: $isInserting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotionDatabaseStateImpl &&
            (identical(other.titles, titles) || other.titles == titles) &&
            (identical(other.newTitle, newTitle) ||
                other.newTitle == newTitle) &&
            (identical(other.isInputting, isInputting) ||
                other.isInputting == isInputting) &&
            (identical(other.isInserting, isInserting) ||
                other.isInserting == isInserting));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, titles, newTitle, isInputting, isInserting);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NotionDatabaseStateImplCopyWith<_$NotionDatabaseStateImpl> get copyWith =>
      __$$NotionDatabaseStateImplCopyWithImpl<_$NotionDatabaseStateImpl>(
          this, _$identity);
}

abstract class _NotionDatabaseState implements NotionDatabaseState {
  const factory _NotionDatabaseState(
      {required final AsyncValue<List<String>> titles,
      required final String newTitle,
      required final bool isInputting,
      required final bool isInserting}) = _$NotionDatabaseStateImpl;

  @override
  AsyncValue<List<String>> get titles;
  @override
  String get newTitle;
  @override
  bool get isInputting;
  @override
  bool get isInserting;
  @override
  @JsonKey(ignore: true)
  _$$NotionDatabaseStateImplCopyWith<_$NotionDatabaseStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
