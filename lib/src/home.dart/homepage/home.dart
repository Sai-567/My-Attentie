import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:test1/src/pages/attendence/attendence.dart';
import 'package:test1/src/pages/splash.dart';

import '../global.dart';
import '../model/student_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    fetchStudentInfo();
    super.initState();
  }

  Uint8List? list;
  void requestImg() async {
    //login this  user and get Cookie and then call image section.
    try {
      final https.Response response = await https.get(
        Uri.parse(
            'http://115.240.101.51:8282/CampusPortalSOA/image/studentPhoto'),
        headers: {
          'Cookie': 'JSESSIONID=${sharedPreferences.getString('cookie')}',
        },
      );
      // print(profileImage);
      setState(() {
        list = response.bodyBytes;
        print(list);
      });
    } catch (e) {}
  }

  late Student student;

  // late Student student;

  fetchStudentInfo() async {
    //try {
    var response = await https.post(
        Uri.parse('http://115.240.101.51:8282//CampusPortalSOA/studentinfo'),
        headers: {
          "Cookie": "JSESSIONID=${sharedPreferences.getString('cookie')}"
        });
    print(response.body);
    var decoded = jsonDecode(response.body);
    if (decoded["detail"].isEmpty) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SplashScreen()));
    } else {
      requestImg();
      student = Student(
        name: decoded["detail"][0]["name"] ?? "Not given",
        regdNo: decoded["detail"][0]["enrollmentno"] ?? "Not given",
        dob: decoded["detail"][0]["dateofbirth"] ?? "Not given",
        branch: decoded["detail"][0]["branchdesc"] ?? "Not given",
        sec: decoded["detail"][0]["sectioncode"] ?? "Not given",
        email: decoded["detail"][0]["semailid"] ?? "Not given",
        mName: decoded["detail"][0]["mothersname"] ?? "Not given",
        address: decoded["detail"][0]["paddress2"] ?? "Not given",
        bloodgroup: decoded["detail"][0]["bloodgroup"] ?? "Not given",
        caddress3: decoded["detail"][0]["caddress2"] ?? "Not given",
        maritalstatus: decoded["detail"][0]["maritalstatus"] ?? "Not given",
        nationality: decoded["detail"][0]["nationality"] ?? "Not given",
        pNo: decoded["detail"][0]["scellno"] ?? "Not given",
        parentNumber: decoded["detail"][0]["stelephoneno"] ?? "Not given",
        phoneNo: decoded["detail"][0]["scellno"] ?? "Not given",
        pincode: decoded["detail"][0]["ppin"] ?? "Not given",
      );
    }

    setState(() {
      isLoading = false;
    });

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Align(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Color.fromARGB(255, 2, 2, 78),
                          child: CircleAvatar(
                            radius: 52,
                            backgroundImage: MemoryImage(list!),
                          ),
                        ),

                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(40),
                        //   child: Image.memory(list!, width: 100),
                        // ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 15),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 1, 34, 83),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.name!,
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 10),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 102, 146, 142),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.regdNo!,
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 1, 34, 83),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.dob!,
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 102, 146, 142),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.branch!,
                          style: const TextStyle(color: Color.fromARGB(255, 5, 5, 5)),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 1, 34, 83),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.sec!,
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 102, 146, 142),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.email!,
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        )),
                      ),
                      
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 1, 34, 83),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.phoneNo!,
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 102, 146, 142),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.address!,
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 20),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 1, 34, 83),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                            child: Text(
                          student.nationality!,
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:Color.fromARGB(255, 58, 1, 73) ,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12))
                            )
                          ),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context)=> const Attendencepage()));
                          }, 
                        child: const Text('Get your attendence')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
  