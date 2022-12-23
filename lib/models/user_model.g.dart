// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: convertHelper(json['id']),
      userName: convertHelper(json['user_name']),
      crateAt: convertHelper(json['created_at']),
      address: convertHelper(json['address']),
      password: convertHelper(json['password']),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_name', instance.userName);
  writeNotNull('created_at', instance.crateAt);
  writeNotNull('address', instance.address);
  writeNotNull('password', instance.password);
  return val;
}
