import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../classes/subject.dart';

import 'package:cached_network_image/cached_network_image.dart';

import '../constants.dart';

class Subjects extends StatefulWidget {
  const Subjects({Key? key}) : super(key: key);


  @override
  State<Subjects> createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  List<Subject> subjectlist = <Subject>[];
  String titlecenter = "No Subject";
 late double screenHeight, screenWidth, resWidth;
  var _tapPosition;
  var numofpage, curpage = 1;
    var color;


    @override
  void initState() {
    super.initState();
   _loadSubjects(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: subjectlist.isEmpty
          ? Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("Subject Avaliable",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(subjectlist.length, (index) {
                    return Card(
                        child: Column(
                      children: [
                        Flexible(
                          flex: 6,
                          child: CachedNetworkImage(
                            imageUrl: CONSTANTS.server +
                                "/mytutor/mobile/assets/courses" +
                                subjectlist[index].subjectId.toString() +
                                '.png',
                            fit: BoxFit.cover,
                            width: resWidth,
                            placeholder: (context, url) =>
                                const LinearProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Column(
                            children: [
                              Text(subjectlist[index].subjectName.toString()),
                              Text(subjectlist[index].subjectPrice.toString()),
                              Text(subjectlist[index].subjectRating.toString()),
                            ],
                          ),
                        )
                      ],
                    ));
                  }),
                )),
                 SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.green;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () =>
                              {_loadSubjects(index + 1)},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
              
            
    );
  }
  void _loadSubjects(int pageno) {
   curpage = pageno;
    numofpage ?? 1;
  http.post(
      Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/loadsubjects.php"),
      body: {'pageno':pageno.toString()}).then((response) {
    var jsondata = jsonDecode(response.body);
    if (response.statusCode == 200 && jsondata['status'] == 'success') {
      var extractdata = jsondata['data'];
      numofpage=int.parse(jsondata['numofpage']);
      if (extractdata['subjects'] != null) {
        subjectlist = <Subject>[];
        extractdata['subjects'].forEach((v) {
          subjectlist.add(Subject.fromJson(v));
        });
      }
    }else{
      titlecenter = "No subjects Available";
    }
    setState(() {
      
    });
  });
}
}


