// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppDataImpl _$$AppDataImplFromJson(Map<String, dynamic> json) =>
    _$AppDataImpl(
      launchCount: (json['launchCount'] as num?)?.toInt() ?? 0,
      hidden: json['hidden'] as bool? ?? false,
    );

Map<String, dynamic> _$$AppDataImplToJson(_$AppDataImpl instance) =>
    <String, dynamic>{
      'launchCount': instance.launchCount,
      'hidden': instance.hidden,
    };
