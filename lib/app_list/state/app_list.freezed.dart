// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppListState {
  List<AppData> get apps =>
      throw _privateConstructorUsedError; // we sacrifice a bit of memory for the sake of runtime performance as it's crucial
// for a launcher to feel smooth at all times
  Map<String, List<AppData>> get appsByLetter =>
      throw _privateConstructorUsedError;
  int get maxLaunches => throw _privateConstructorUsedError;
  String get filter => throw _privateConstructorUsedError;
  bool get showingSettings => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;
  bool get isLetterFilter => throw _privateConstructorUsedError;
  dynamic get minLaunches => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppListStateCopyWith<AppListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppListStateCopyWith<$Res> {
  factory $AppListStateCopyWith(
          AppListState value, $Res Function(AppListState) then) =
      _$AppListStateCopyWithImpl<$Res, AppListState>;
  @useResult
  $Res call(
      {List<AppData> apps,
      Map<String, List<AppData>> appsByLetter,
      int maxLaunches,
      String filter,
      bool showingSettings,
      bool loading,
      bool isLetterFilter,
      dynamic minLaunches});
}

/// @nodoc
class _$AppListStateCopyWithImpl<$Res, $Val extends AppListState>
    implements $AppListStateCopyWith<$Res> {
  _$AppListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apps = null,
    Object? appsByLetter = null,
    Object? maxLaunches = null,
    Object? filter = null,
    Object? showingSettings = null,
    Object? loading = null,
    Object? isLetterFilter = null,
    Object? minLaunches = freezed,
  }) {
    return _then(_value.copyWith(
      apps: null == apps
          ? _value.apps
          : apps // ignore: cast_nullable_to_non_nullable
              as List<AppData>,
      appsByLetter: null == appsByLetter
          ? _value.appsByLetter
          : appsByLetter // ignore: cast_nullable_to_non_nullable
              as Map<String, List<AppData>>,
      maxLaunches: null == maxLaunches
          ? _value.maxLaunches
          : maxLaunches // ignore: cast_nullable_to_non_nullable
              as int,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
      showingSettings: null == showingSettings
          ? _value.showingSettings
          : showingSettings // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLetterFilter: null == isLetterFilter
          ? _value.isLetterFilter
          : isLetterFilter // ignore: cast_nullable_to_non_nullable
              as bool,
      minLaunches: freezed == minLaunches
          ? _value.minLaunches
          : minLaunches // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppListStateImplCopyWith<$Res>
    implements $AppListStateCopyWith<$Res> {
  factory _$$AppListStateImplCopyWith(
          _$AppListStateImpl value, $Res Function(_$AppListStateImpl) then) =
      __$$AppListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<AppData> apps,
      Map<String, List<AppData>> appsByLetter,
      int maxLaunches,
      String filter,
      bool showingSettings,
      bool loading,
      bool isLetterFilter,
      dynamic minLaunches});
}

/// @nodoc
class __$$AppListStateImplCopyWithImpl<$Res>
    extends _$AppListStateCopyWithImpl<$Res, _$AppListStateImpl>
    implements _$$AppListStateImplCopyWith<$Res> {
  __$$AppListStateImplCopyWithImpl(
      _$AppListStateImpl _value, $Res Function(_$AppListStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? apps = null,
    Object? appsByLetter = null,
    Object? maxLaunches = null,
    Object? filter = null,
    Object? showingSettings = null,
    Object? loading = null,
    Object? isLetterFilter = null,
    Object? minLaunches = freezed,
  }) {
    return _then(_$AppListStateImpl(
      apps: null == apps
          ? _value._apps
          : apps // ignore: cast_nullable_to_non_nullable
              as List<AppData>,
      appsByLetter: null == appsByLetter
          ? _value._appsByLetter
          : appsByLetter // ignore: cast_nullable_to_non_nullable
              as Map<String, List<AppData>>,
      maxLaunches: null == maxLaunches
          ? _value.maxLaunches
          : maxLaunches // ignore: cast_nullable_to_non_nullable
              as int,
      filter: null == filter
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as String,
      showingSettings: null == showingSettings
          ? _value.showingSettings
          : showingSettings // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLetterFilter: null == isLetterFilter
          ? _value.isLetterFilter
          : isLetterFilter // ignore: cast_nullable_to_non_nullable
              as bool,
      minLaunches: freezed == minLaunches ? _value.minLaunches! : minLaunches,
    ));
  }
}

/// @nodoc

class _$AppListStateImpl extends _AppListState {
  const _$AppListStateImpl(
      {final List<AppData> apps = const [],
      final Map<String, List<AppData>> appsByLetter = const {},
      this.maxLaunches = 0,
      this.filter = '',
      this.showingSettings = false,
      this.loading = false,
      this.isLetterFilter = false,
      this.minLaunches = 0})
      : _apps = apps,
        _appsByLetter = appsByLetter,
        super._();

  final List<AppData> _apps;
  @override
  @JsonKey()
  List<AppData> get apps {
    if (_apps is EqualUnmodifiableListView) return _apps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_apps);
  }

// we sacrifice a bit of memory for the sake of runtime performance as it's crucial
// for a launcher to feel smooth at all times
  final Map<String, List<AppData>> _appsByLetter;
// we sacrifice a bit of memory for the sake of runtime performance as it's crucial
// for a launcher to feel smooth at all times
  @override
  @JsonKey()
  Map<String, List<AppData>> get appsByLetter {
    if (_appsByLetter is EqualUnmodifiableMapView) return _appsByLetter;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_appsByLetter);
  }

  @override
  @JsonKey()
  final int maxLaunches;
  @override
  @JsonKey()
  final String filter;
  @override
  @JsonKey()
  final bool showingSettings;
  @override
  @JsonKey()
  final bool loading;
  @override
  @JsonKey()
  final bool isLetterFilter;
  @override
  @JsonKey()
  final dynamic minLaunches;

  @override
  String toString() {
    return 'AppListState(apps: $apps, appsByLetter: $appsByLetter, maxLaunches: $maxLaunches, filter: $filter, showingSettings: $showingSettings, loading: $loading, isLetterFilter: $isLetterFilter, minLaunches: $minLaunches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppListStateImpl &&
            const DeepCollectionEquality().equals(other._apps, _apps) &&
            const DeepCollectionEquality()
                .equals(other._appsByLetter, _appsByLetter) &&
            (identical(other.maxLaunches, maxLaunches) ||
                other.maxLaunches == maxLaunches) &&
            (identical(other.filter, filter) || other.filter == filter) &&
            (identical(other.showingSettings, showingSettings) ||
                other.showingSettings == showingSettings) &&
            (identical(other.loading, loading) || other.loading == loading) &&
            (identical(other.isLetterFilter, isLetterFilter) ||
                other.isLetterFilter == isLetterFilter) &&
            const DeepCollectionEquality()
                .equals(other.minLaunches, minLaunches));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_apps),
      const DeepCollectionEquality().hash(_appsByLetter),
      maxLaunches,
      filter,
      showingSettings,
      loading,
      isLetterFilter,
      const DeepCollectionEquality().hash(minLaunches));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppListStateImplCopyWith<_$AppListStateImpl> get copyWith =>
      __$$AppListStateImplCopyWithImpl<_$AppListStateImpl>(this, _$identity);
}

abstract class _AppListState extends AppListState {
  const factory _AppListState(
      {final List<AppData> apps,
      final Map<String, List<AppData>> appsByLetter,
      final int maxLaunches,
      final String filter,
      final bool showingSettings,
      final bool loading,
      final bool isLetterFilter,
      final dynamic minLaunches}) = _$AppListStateImpl;
  const _AppListState._() : super._();

  @override
  List<AppData> get apps;
  @override // we sacrifice a bit of memory for the sake of runtime performance as it's crucial
// for a launcher to feel smooth at all times
  Map<String, List<AppData>> get appsByLetter;
  @override
  int get maxLaunches;
  @override
  String get filter;
  @override
  bool get showingSettings;
  @override
  bool get loading;
  @override
  bool get isLetterFilter;
  @override
  dynamic get minLaunches;
  @override
  @JsonKey(ignore: true)
  _$$AppListStateImplCopyWith<_$AppListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
