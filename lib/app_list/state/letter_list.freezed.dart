// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'letter_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LetterListState {
  int? get index => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LetterListStateCopyWith<LetterListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterListStateCopyWith<$Res> {
  factory $LetterListStateCopyWith(
          LetterListState value, $Res Function(LetterListState) then) =
      _$LetterListStateCopyWithImpl<$Res, LetterListState>;
  @useResult
  $Res call({int? index});
}

/// @nodoc
class _$LetterListStateCopyWithImpl<$Res, $Val extends LetterListState>
    implements $LetterListStateCopyWith<$Res> {
  _$LetterListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_value.copyWith(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LetterListStateImplCopyWith<$Res>
    implements $LetterListStateCopyWith<$Res> {
  factory _$$LetterListStateImplCopyWith(_$LetterListStateImpl value,
          $Res Function(_$LetterListStateImpl) then) =
      __$$LetterListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? index});
}

/// @nodoc
class __$$LetterListStateImplCopyWithImpl<$Res>
    extends _$LetterListStateCopyWithImpl<$Res, _$LetterListStateImpl>
    implements _$$LetterListStateImplCopyWith<$Res> {
  __$$LetterListStateImplCopyWithImpl(
      _$LetterListStateImpl _value, $Res Function(_$LetterListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = freezed,
  }) {
    return _then(_$LetterListStateImpl(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$LetterListStateImpl implements _LetterListState {
  const _$LetterListStateImpl({this.index});

  @override
  final int? index;

  @override
  String toString() {
    return 'LetterListState(index: $index)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterListStateImpl &&
            (identical(other.index, index) || other.index == index));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LetterListStateImplCopyWith<_$LetterListStateImpl> get copyWith =>
      __$$LetterListStateImplCopyWithImpl<_$LetterListStateImpl>(
          this, _$identity);
}

abstract class _LetterListState implements LetterListState {
  const factory _LetterListState({final int? index}) = _$LetterListStateImpl;

  @override
  int? get index;
  @override
  @JsonKey(ignore: true)
  _$$LetterListStateImplCopyWith<_$LetterListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
