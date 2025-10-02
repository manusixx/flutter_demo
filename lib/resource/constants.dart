import 'package:flutter/material.dart';

class Constants {

  static const Color greenColorApp = Color.fromRGBO(50, 171, 172, 1);
  static const Color greyColorApp = Color.fromRGBO(156, 156, 156, 1);
  static const Color colorBaseFButton = Color.fromARGB(200, 50, 171, 172);
  static const double fontsizeListTile = 18;
  static const double fontsizeButton = 17;
  static const String urlAuthority = "http://ec2-18-223-248-173.us-east-2.compute.amazonaws.com:8085";
  static const String contextPath = "api/demo";
  static const String contentTypeHeader = "application/json";
  static const String authorizationHeader = "Bearer ";
  //Student API
  static const String studentAPIServiceGetAll = "$contextPath/student/all";
  static const String studentAPIServiceGetbyID = "$contextPath/student/id";
  static const String studentAPIServiceCreate = "$contextPath/student/save";
  static const String studentAPIServiceUpdate = "$contextPath/student/update";
  static const String studentAPIServiceDelete = "$contextPath/student/delete";
  
}
