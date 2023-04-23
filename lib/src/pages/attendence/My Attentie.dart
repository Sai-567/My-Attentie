import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:test1/src/model/attendence_model.dart';

import '../../global.dart';

class Attendencepage extends StatefulWidget {
  const Attendencepage({super.key});

  @override
  State<Attendencepage> createState() => _AttendencepageState();
}

class _AttendencepageState extends State<Attendencepage> {
  List<AttendenceModel> attendence = [];
  List<Color> color = [
    Color.fromARGB(255, 27, 18, 103),
    Color.fromARGB(255, 66, 17, 74),
    Color.fromARGB(255, 117, 16, 50),
    Color.fromARGB(255, 0, 103, 93),
    Color.fromARGB(255, 23, 71, 10),
  ];
  bool isLoading = true;
  @override
  void initState() {
    fetchAttedenceId();
    super.initState();
  }

  fetchAttedenceId() async {
    var response = await https.post(
      Uri.parse(
          'http://115.240.101.71:8282/CampusPortalSOA/studentSemester/lov'),
      headers: {
        'Cookie': 'JSESSIONID=${sharedPreferences.getString('cookie')}',
      },
    );
    var decode = jsonDecode(response.body);
    String attendenceid = decode["studentdata"][0]["REGISTRATIONID"];
    fetchAttendence(attendenceid);
  }

  fetchAttendence(String atId) async {
    var response = await https.post(
      Uri.parse('http://115.240.101.51:8282/CampusPortalSOA/attendanceinfo'),
      body: json.encode({"registerationid": "ITERRETD2209A0000001"}),
      headers: {
        'Cookie': 'JSESSIONID=${sharedPreferences.getString('cookie')}',
      },
    );
    var decode = jsonDecode(response.body);
    int len = decode["griddata"].length;
    for (int e = 0; e < len; e++) {
      attendence.add(AttendenceModel(
        latt: decode["griddata"][e]["Latt"],
        patt: decode["griddata"][e]["Patt"],
        subject: decode["griddata"][e]["subject"],
        totalAttendence: decode["griddata"][e]["TotalAttandence"],
      ));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: const Text('Attendence'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: attendence.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                    bottom: 5,
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                      color: color[index],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Total attendence : ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            attendence[index].totalAttendence.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Lect : ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            attendence[index].latt.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Pract : ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            attendence[index].patt.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Subject : ',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              attendence[index].subject.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}