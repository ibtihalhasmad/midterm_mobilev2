import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../classes/tutor.dart';
import '../constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Tutors extends StatefulWidget {
  const Tutors({Key? key}) : super(key: key);


  @override
  State<Tutors> createState() => _TutorsState();
}

class _TutorsState extends State<Tutors> {
  List<Tutor> tutorlist = <Tutor>[];
  String titlecenter = "No Tutors";
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
     screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      body: tutorlist.isEmpty
          ? Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("Tutor Available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                    child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(tutorlist.length, (index) {
                    return Card(
                        child: Column(
                      children: [
                        Flexible(
                          flex: 6,
                          child: CachedNetworkImage(
                            imageUrl: CONSTANTS.server +
                                "/mytutor/mobile/assets/tutors" +
                                tutorlist[index].tutorId.toString() +
                                '.jpg',
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
                              Text(tutorlist[index].tutorName.toString()),
                              Text(tutorlist[index].tutorPhone.toString()),
                              Text(tutorlist[index].tutorEmail.toString()),
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
      Uri.parse(CONSTANTS.server + "/mytutor/mobile/php/loadtutors.php"),
      body: {}).then((response) {
    var jsondata = jsonDecode(response.body);
    if (response.statusCode == 200 && jsondata['status'] == 'success') {
      var extractdata = jsondata['data'];
      if (extractdata['Tutors'] != null) {
        tutorlist = <Tutor>[];
        extractdata[' Tutors'].forEach((v) {
          tutorlist.add(Tutor.fromJson(v));
        });
      }
    }else{
      titlecenter = "No Tutors Available";
    }
    setState(() {
      
    });
  });
}
}


