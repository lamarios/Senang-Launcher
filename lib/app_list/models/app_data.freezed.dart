// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppData _$AppDataFromJson(Map<String, dynamic> json) {
  return _AppData.fromJson(json);
}

/// @nodoc
mixin _$AppData {
  bool get hidden => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get launchCount => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get hasNotification => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Application? get app => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppDataCopyWith<AppData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDataCopyWith<$Res> {
  factory $AppDataCopyWith(AppData value, $Res Function(AppData) then) =
      _$AppDataCopyWithImpl<$Res, AppData>;
  @useResult
  $Res call(
      {bool hidden,
      @JsonKey(includeFromJson: false, includeToJson: false) int launchCount,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool hasNotification,
      @JsonKey(includeFromJson: false, includeToJson: false) Application? app});
}

/// @nodoc
class _$AppDataCopyWithImpl<$Res, $Val extends AppData>
    implements $AppDataCopyWith<$Res> {
  _$AppDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hidden = null,
    Object? launchCount = null,
    Object? hasNotification = null,
    Object? app = freezed,
  }) {
    return _then(_value.copyWith(
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      launchCount: null == launchCount
          ? _value.launchCount
          : launchCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasNotification: null == hasNotification
          ? _value.hasNotification
          : hasNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      app: freezed == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as Application?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppDataImplCopyWith<$Res> implements $AppDataCopyWith<$Res> {
  factory _$$AppDataImplCopyWith(
          _$AppDataImpl value, $Res Function(_$AppDataImpl) then) =
      __$$AppDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool hidden,
      @JsonKey(includeFromJson: false, includeToJson: false) int launchCount,
      @JsonKey(includeFromJson: false, includeToJson: false)
      bool hasNotification,
      @JsonKey(includeFromJson: false, includeToJson: false) Application? app});
}

/// @nodoc
class __$$AppDataImplCopyWithImpl<$Res>
    extends _$AppDataCopyWithImpl<$Res, _$AppDataImpl>
    implements _$$AppDataImplCopyWith<$Res> {
  __$$AppDataImplCopyWithImpl(
      _$AppDataImpl _value, $Res Function(_$AppDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hidden = null,
    Object? launchCount = null,
    Object? hasNotification = null,
    Object? app = freezed,
  }) {
    return _then(_$AppDataImpl(
      hidden: null == hidden
          ? _value.hidden
          : hidden // ignore: cast_nullable_to_non_nullable
              as bool,
      launchCount: null == launchCount
          ? _value.launchCount
          : launchCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasNotification: null == hasNotification
          ? _value.hasNotification
          : hasNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      app: freezed == app
          ? _value.app
          : app // ignore: cast_nullable_to_non_nullable
              as Application?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppDataImpl implements _AppData {
  const _$AppDataImpl(
      {this.hidden = false,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.launchCount = 0,
      @JsonKey(includeFromJson: false, includeToJson: false)
      this.hasNotification = false,
      @JsonKey(includeFromJson: false, includeToJson: false) this.app});

  factory _$AppDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppDataImplFromJson(json);

  @override
  @JsonKey()
  final bool hidden;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int launchCount;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool hasNotification;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Application? app;

  @override
  String toString() {
    return 'AppData(hidden: $hidden, launchCount: $launchCount, hasNotification: $hasNotification, app: $app)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDataImpl &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            (identical(other.launchCount, launchCount) ||
                other.launchCount == launchCount) &&
            (identical(other.hasNotification, hasNotification) ||
                other.hasNotification == hasNotification) &&
            (identical(other.app, app) || other.app == app));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, hidden, launchCount, hasNotification, app);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDataImplCopyWith<_$AppDataImpl> get copyWith =>
      __$$AppDataImplCopyWithImpl<_$AppDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppDataImplToJson(
      this,
    );
  }
}

abstract class _AppData implements AppData {
  const factory _AppData(
      {final bool hidden,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final int launchCount,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final bool hasNotification,
      @JsonKey(includeFromJson: false, includeToJson: false)
      final Application? app}) = _$AppDataImpl;

  factory _AppData.fromJson(Map<String, dynamic> json) = _$AppDataImpl.fromJson;

  @override
  bool get hidden;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get launchCount;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get hasNotification;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  Application? get app;
  @override
  @JsonKey(ignore: true)
  _$$AppDataImplCopyWith<_$AppDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
