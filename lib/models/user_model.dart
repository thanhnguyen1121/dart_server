import 'package:json_annotation/json_annotation.dart';
import 'package:my_project/utils/type_convert_helper.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: false, includeIfNull: false)
class UserModel {
  UserModel({
    this.id,
    this.userName,
    this.crateAt,
    this.address,
    this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @JsonKey(name: 'id', fromJson: convertHelper<String>)
  int? id;

  @JsonKey(name: 'user_name', fromJson: convertHelper<String>)
  String? userName;

  @JsonKey(name: 'created_at', fromJson: convertHelper<String>)
  String? crateAt;

  @JsonKey(name: 'address', fromJson: convertHelper<String>)
  String? address;

  @JsonKey(name: 'password', fromJson: convertHelper<String>)
  String? password;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
