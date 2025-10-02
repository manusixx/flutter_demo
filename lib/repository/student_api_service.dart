import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../model/student_model.dart';
import '../resource/constants.dart';

class StudentRepository {

  Future<List<StudentModel>> getAllStudents() async {
    final url = Uri.parse('${Constants.urlAuthority}/${Constants.studentAPIServiceGetAll}');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((dynamic json) => StudentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<StudentModel> getStudentById(int id) async {
    final url = Uri.parse('${Constants.urlAuthority}/${Constants.studentAPIServiceGetbyID}/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return StudentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load student');
    }
  }

  Future<StudentModel> createStudent(StudentModel student) async {
    final url = Uri.parse('${Constants.urlAuthority}/${Constants.studentAPIServiceCreate}');
    final response = await http.post(url,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: json.encode(student.toJson()));

    if (response.statusCode == 200) {
      return StudentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create student');
    }
  }

  Future<StudentModel> updateStudent(StudentModel student) async {
    final url = Uri.parse('${Constants.urlAuthority}/${Constants.studentAPIServiceUpdate}');
    final response = await http.put(url,
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
      body: json.encode(student.toJson()));

    if (response.statusCode == 200) {
      return StudentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update student');
    }
  }

  Future<void> deleteStudent(int id) async {
    final url = Uri.parse('${Constants.urlAuthority}/${Constants.studentAPIServiceUpdate}/$id');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete student');
    }
  }
}
