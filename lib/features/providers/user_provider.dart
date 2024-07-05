import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tls/features/models/user_model.dart';

class UserProvider extends ChangeNotifier{
  UserModel? userModel;

  UserModel? getUser() => userModel;

  addUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    this.userModel = userModel;
    await preferences.setString("tls_user", jsonEncode(userModel.toJson()));
    notifyListeners();
  }

  removeUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove("tls_user");
    userModel = null;
  }
}
