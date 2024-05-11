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
  double? get rawIndex => throw _privateConstructorUsedError;
  double? get xOffset => throw _privateConstructorUsedError;
  List<String> get letters => throw _privateConstructorUsedError;
  bool get fromInvisible => throw _privateConstructorUsedError;

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
  $Res call(
      {int? index,
      double? rawIndex,
      double? xOffset,
      List<String> letters,
      bool fromInvisible});
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
    Object? rawIndex = freezed,
    Object? xOffset = freezed,
    Object? letters = null,
    Object? fromInvisible = null,
  }) {
    return _then(_value.copyWith(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      rawIndex: freezed == rawIndex
          ? _value.rawIndex
          : rawIndex // ignore: cast_nullable_to_non_nullable
              as double?,
      xOffset: freezed == xOffset
          ? _value.xOffset
          : xOffset // ignore: cast_nullable_to_non_nullable
              as double?,
      letters: null == letters
          ? _value.letters
          : letters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fromInvisible: null == fromInvisible
          ? _value.fromInvisible
          : fromInvisible // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call(
      {int? index,
      double? rawIndex,
      double? xOffset,
      List<String> letters,
      bool fromInvisible});
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
    Object? rawIndex = freezed,
    Object? xOffset = freezed,
    Object? letters = null,
    Object? fromInvisible = null,
  }) {
    return _then(_$LetterListStateImpl(
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      rawIndex: freezed == rawIndex
          ? _value.rawIndex
          : rawIndex // ignore: cast_nullable_to_non_nullable
              as double?,
      xOffset: freezed == xOffset
          ? _value.xOffset
          : xOffset // ignore: cast_nullable_to_non_nullable
              as double?,
      letters: null == letters
          ? _value._letters
          : letters // ignore: cast_nullable_to_non_nullable
              as List<String>,
      fromInvisible: null == fromInvisible
          ? _value.fromInvisible
          : fromInvisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LetterListStateImpl
    with DiagnosticableTreeMixin
    implements _LetterListState {
  const _$LetterListStateImpl(
      {this.index,
      this.rawIndex,
      this.xOffset,
      final List<String> letters = const [],
      this.fromInvisible = false})
      : _letters = letters;

  @override
  final int? index;
  @override
  final double? rawIndex;
  @override
  final double? xOffset;
  final List<String> _letters;
  @override
  @JsonKey()
  List<String> get letters {
    if (_letters is EqualUnmodifiableListView) return _letters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_letters);
  }

  @override
  @JsonKey()
  final bool fromInvisible;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LetterListState(index: $index, rawIndex: $rawIndex, xOffset: $xOffset, letters: $letters, fromInvisible: $fromInvisible)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LetterListState'))
      ..add(DiagnosticsProperty('index', index))
      ..add(DiagnosticsProperty('rawIndex', rawIndex))
      ..add(DiagnosticsProperty('xOffset', xOffset))
      ..add(DiagnosticsProperty('letters', letters))
      ..add(DiagnosticsProperty('fromInvisible', fromInvisible));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterListStateImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.rawIndex, rawIndex) ||
                other.rawIndex == rawIndex) &&
            (identical(other.xOffset, xOffset) || other.xOffset == xOffset) &&
            const DeepCollectionEquality().equals(other._letters, _letters) &&
            (identical(other.fromInvisible, fromInvisible) ||
                other.fromInvisible == fromInvisible));
  }

  @override
  int get hashCode => Object.hash(runtimeType, index, rawIndex, xOffset,
      const DeepCollectionEquality().hash(_letters), fromInvisible);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LetterListStateImplCopyWith<_$LetterListStateImpl> get copyWith =>
      __$$LetterListStateImplCopyWithImpl<_$LetterListStateImpl>(
          this, _$identity);
}

abstract class _LetterListState implements LetterListState {
  const factory _LetterListState(
      {final int? index,
      final double? rawIndex,
      final double? xOffset,
      final List<String> letters,
      final bool fromInvisible}) = _$LetterListStateImpl;

  @override
  int? get index;
  @override
  double? get rawIndex;
  @override
  double? get xOffset;
  @override
  List<String> get letters;
  @override
  bool get fromInvisible;
  @override
  @JsonKey(ignore: true)
  _$$LetterListStateImplCopyWith<_$LetterListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
