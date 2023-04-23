import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:test1/src/global.dart';
import 'package:test1/src/pages/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController regdNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  // tryLoggingThisUser() async {
  //   var response = await https.post(
  //       Uri.parse('http://115.240.101.71:8282/CampusPortalSOA/login'),
  //       body: json.encode({
  //         "username": regdNo.text,
  //         "password": password.text,
  //         "MemberType": "S"
  //       }));
  //   var decoded = jsonDecode(response.body);
  //   print(decoded);

  // }

  setCookie(response) {
    String rawCookie = response.headers['set-cookie']!;
    int index = rawCookie.indexOf(';');
    String refreshToken =
        (index == -1) ? rawCookie : rawCookie.substring(0, index);
    int idx = refreshToken.indexOf("=");
    if (kDebugMode) {
      print(refreshToken.substring(idx + 1).trim());
    }
    String cookieID = refreshToken.substring(idx + 1).trim();
    sharedPreferences.setString('cookie', cookieID);
  }

  tryLoggingThisUser() async {
    var response = await https.post(
        Uri.parse('http://115.240.101.51:8282/CampusPortalSOA/login'),
        body: json.encode({
          "username": regdNo.text,
          "password": password.text,
          "MemberType": "S"
        }));
    var decoded = jsonDecode(response.body);
    print(decoded);
    if (decoded["status"].toString().contains("success")) {
      //cookie save
      setCookie(response);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
          sharedPreferences.setBool("isLoggedin", true);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(decoded["message"])));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(decoded["message"])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 141, 197, 205),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 57, 10, 10),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Access your account',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: regdNo,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: "Enter Registraton Number",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  controller: password,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                    hintText: "Enter Password",
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 56, 4, 56)
                    ),
                    
                    onPressed: () {
                      tryLoggingThisUser();
                    },
                    child: const Text('Sign In'),
                  ),
                ),
                // const SizedBox(height: 10),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Container(
                //         height: 1,
                //         color: Colors.grey,
                //       ),
                //     ),
                //     const SizedBox(width: 5),
                //     const Text('sign in with'),
                //     const SizedBox(width: 5),
                //     Expanded(
                //       child: Container(
                //         height: 1,
                //         color: Colors.grey,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 10),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     child: const Text('Google'),
                //   ),
                // ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {},
                //     child: const Text('Facebook'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}