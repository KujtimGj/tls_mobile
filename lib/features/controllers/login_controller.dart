import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tls/core/api.dart';
import 'package:http/http.dart' as http;
import 'package:tls/core/errors/failures.dart';
import 'package:tls/features/models/user_model.dart';
import 'package:tls/features/providers/user_provider.dart';
import 'package:tls/main.dart';

class LoginController{
  static Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<Either<Failure,dynamic>> signIn(BuildContext context, String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    Uri url = Uri.parse("$host$loginRoute");
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(headers: requestHeaders, url,body: body);
      print(response.statusCode);
      print(response.body);
    if(response.statusCode == 200){
      var body = jsonDecode(response.body);
      if(body['message'] == "success"){
      await prefs.setString("token", body['token']);
      Map<String,dynamic>? userData=body['payload'];
      if(userData!=null){
        prefs.setString("fullname", body['payload']['fullname']);
        prefs.setString("email", body['payload']['email']);
      }
        UserModel userModel = UserModel.fromJson(body['payload']);
        userProvider.addUser(userModel);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const Base()),
                (route) => false);
      }
      else if(body['message'] == "invalid_credentials"){
        print("Sdfsd");
        return Left(InvalidCredentials(message: "Email or password incorrect"));
      }
      return const Right("");
    }
    else if(response.statusCode == 401){
      return Left(WrongDataFailure(message: "Email or password is incorrect!"));
    }
    else{
      return Left(ServerFailure());
    }


  }
}