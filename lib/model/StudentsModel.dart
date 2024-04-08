// To parse this JSON data, do
//
//     final studentsModel = studentsModelFromJson(jsonString);

import 'dart:convert';

StudentsModel studentsModelFromJson(String str) => StudentsModel.fromJson(json.decode(str));

String studentsModelToJson(StudentsModel data) => json.encode(data.toJson());

class StudentsModel {
  List<Student>? students;

  StudentsModel({
    this.students,
  });

  factory StudentsModel.fromJson(Map<String, dynamic> json) => StudentsModel(
    students: json["students"] == null ? [] : List<Student>.from(json["students"]!.map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "students": students == null ? [] : List<dynamic>.from(students!.map((x) => x.toJson())),
  };
}

class Student {
  String? id;
  String? fullname;
  String? gender;
  String? className;
  String? parents;
  String? address;
  DateTime? dateofbirth;
  String? phone;
  String? username;
  String? password;
  int? v;

  Student({
    this.id,
    this.fullname,
    this.gender,
    this.className,
    this.parents,
    this.address,
    this.dateofbirth,
    this.phone,
    this.username,
    this.password,
    this.v,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json["_id"],
    fullname: json["fullname"],
    gender: json["gender"],
    className: json["className"],
    parents: json["parents"],
    address: json["address"],
    dateofbirth: json["dateofbirth"] == null ? null : DateTime.parse(json["dateofbirth"]),
    phone: json["phone"],
    username: json["username"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullname": fullname,
    "gender": gender,
    "className": className,
    "parents": parents,
    "address": address,
    "dateofbirth": dateofbirth?.toIso8601String(),
    "phone": phone,
    "username": username,
    "password": password,
    "__v": v,
  };
}
