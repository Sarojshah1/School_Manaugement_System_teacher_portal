// To parse this JSON data, do
//
//     final teacherprofileModel = teacherprofileModelFromJson(jsonString);

import 'dart:convert';

TeacherprofileModel teacherprofileModelFromJson(String str) => TeacherprofileModel.fromJson(json.decode(str));

String teacherprofileModelToJson(TeacherprofileModel data) => json.encode(data.toJson());

class TeacherprofileModel {
  String? id;
  String? fullname;
  String? phonenumber;
  String? role;
  String? subject;
  String? gender;
  String? className;
  String? address;
  String? dateofbirth;
  String? username;
  String? password;
  int? v;

  TeacherprofileModel({
    this.id,
    this.fullname,
    this.phonenumber,
    this.role,
    this.subject,
    this.gender,
    this.className,
    this.address,
    this.dateofbirth,
    this.username,
    this.password,
    this.v,
  });

  factory TeacherprofileModel.fromJson(Map<String, dynamic> json) => TeacherprofileModel(
    id: json["_id"],
    fullname: json["fullname"],
    phonenumber: json["phonenumber"],
    role: json["role"],
    subject: json["subject"],
    gender: json["gender"],
    className: json["className"],
    address: json["address"],
    dateofbirth: json["dateofbirth"],
    username: json["username"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullname": fullname,
    "phonenumber": phonenumber,
    "role": role,
    "subject": subject,
    "gender": gender,
    "className": className,
    "address": address,
    "dateofbirth": dateofbirth,
    "username": username,
    "password": password,
    "__v": v,
  };
}
