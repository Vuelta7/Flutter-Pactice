// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_request_no.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyPokemonsModel {
  String get name;
  String get spritesUrl;

  /// Create a copy of MyPokemonsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MyPokemonsModelCopyWith<MyPokemonsModel> get copyWith =>
      _$MyPokemonsModelCopyWithImpl<MyPokemonsModel>(
          this as MyPokemonsModel, _$identity);

  /// Serializes this MyPokemonsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MyPokemonsModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.spritesUrl, spritesUrl) ||
                other.spritesUrl == spritesUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, spritesUrl);

  @override
  String toString() {
    return 'MyPokemonsModel(name: $name, spritesUrl: $spritesUrl)';
  }
}

/// @nodoc
abstract mixin class $MyPokemonsModelCopyWith<$Res> {
  factory $MyPokemonsModelCopyWith(
          MyPokemonsModel value, $Res Function(MyPokemonsModel) _then) =
      _$MyPokemonsModelCopyWithImpl;
  @useResult
  $Res call({String name, String spritesUrl});
}

/// @nodoc
class _$MyPokemonsModelCopyWithImpl<$Res>
    implements $MyPokemonsModelCopyWith<$Res> {
  _$MyPokemonsModelCopyWithImpl(this._self, this._then);

  final MyPokemonsModel _self;
  final $Res Function(MyPokemonsModel) _then;

  /// Create a copy of MyPokemonsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? spritesUrl = null,
  }) {
    return _then(_self.copyWith(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      spritesUrl: null == spritesUrl
          ? _self.spritesUrl
          : spritesUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MyPokemonsModel implements MyPokemonsModel {
  const _MyPokemonsModel({required this.name, required this.spritesUrl});
  factory _MyPokemonsModel.fromJson(Map<String, dynamic> json) =>
      _$MyPokemonsModelFromJson(json);

  @override
  final String name;
  @override
  final String spritesUrl;

  /// Create a copy of MyPokemonsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MyPokemonsModelCopyWith<_MyPokemonsModel> get copyWith =>
      __$MyPokemonsModelCopyWithImpl<_MyPokemonsModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MyPokemonsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MyPokemonsModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.spritesUrl, spritesUrl) ||
                other.spritesUrl == spritesUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, spritesUrl);

  @override
  String toString() {
    return 'MyPokemonsModel(name: $name, spritesUrl: $spritesUrl)';
  }
}

/// @nodoc
abstract mixin class _$MyPokemonsModelCopyWith<$Res>
    implements $MyPokemonsModelCopyWith<$Res> {
  factory _$MyPokemonsModelCopyWith(
          _MyPokemonsModel value, $Res Function(_MyPokemonsModel) _then) =
      __$MyPokemonsModelCopyWithImpl;
  @override
  @useResult
  $Res call({String name, String spritesUrl});
}

/// @nodoc
class __$MyPokemonsModelCopyWithImpl<$Res>
    implements _$MyPokemonsModelCopyWith<$Res> {
  __$MyPokemonsModelCopyWithImpl(this._self, this._then);

  final _MyPokemonsModel _self;
  final $Res Function(_MyPokemonsModel) _then;

  /// Create a copy of MyPokemonsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? spritesUrl = null,
  }) {
    return _then(_MyPokemonsModel(
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      spritesUrl: null == spritesUrl
          ? _self.spritesUrl
          : spritesUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
