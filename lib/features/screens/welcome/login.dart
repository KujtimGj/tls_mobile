import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tls/features/controllers/login_controller.dart';
import 'package:tls/features/screens/home/home.dart';
import 'package:tls/main.dart';

import '../../../core/dimensions.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();



  login() async {
    if(_email.text.isEmpty || _password.text.isEmpty){
      showToast("Please complete all fields",context: context,curve: Curves.easeOut);
    }
    else {
      LoginController loginController = LoginController();
      var data = await loginController.signIn(context, _email.text, _password.text);
      data.fold((left){
        if(left.props.isNotEmpty){
          showToast(left.props.first.toString());
        }
      }, (right){

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: getPhoneWitdth(context) * 0.08),
          child: ListView(
            children: [
              SizedBox(height: getPhoneHeight(context) * 0.1),
              const Center(
                child: Text(
                  "TLS",
                  style: TextStyle(
                      fontSize: 50,
                      fontFamily: 'Kanit',
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 30, fontFamily: 'Kanit'),
              ),
              const SizedBox(height: 40),
              const Text("Email",style: TextStyle(fontSize: 17),),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: TextFormField(
                  controller: _email,
                  decoration:  InputDecoration(
                    hintText: "user@email.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1, color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:const BorderSide(width: 1, color: Colors.grey)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text("Password",style: TextStyle(fontSize: 17),),
              const SizedBox(height: 10),
              SizedBox(
                height: 60,
                child: TextFormField(
                  controller: _password,
                  decoration: InputDecoration(
                    hintText: "*******",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1, color: Color(0xffeaeaea))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1, color: Color(0xffeaeaea))),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  login();

                },
                child: Container(
                  height: getPhoneHeight(context) * 0.07,
                  width: getPhoneWitdth(context),
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.black, borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                "Forgot passowrd?",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              )
            ],
          ),
        ));
  }
}
