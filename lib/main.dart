import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    DropList();
    super.initState();
  }

  late List<String> cityList,statelist;
    String? chosenValue;
    String? StateValue;
  //String myCity;

  DropList() async {
    Map data = {
      "Token": "KDLFDBDDFDFJDKFDLFD47",
      "CallType": "1",
    };
    var body = json.encode(data);
    var url = Uri.parse('http://api.habitushrsolutions.com/api/RMSAPI/Master');
    var response = await http.post(url, body: body,
      headers: {'Content-Type': 'application/json'},
    );
    // print(response.body);
    {
      if (response.statusCode == 200) {
        cityList = [];
        statelist = [];
        List jsondecode = json.decode(response.body);
        for (int i = 0; i < jsondecode.length; i++) {
          StateModel stateModel = StateModel.fromJson(jsondecode[i]);

          cityList.add(stateModel.stateName);
          print(cityList);

          statelist.add(stateModel.stateCode);
          print(statelist);
        }
      }

      print("${response.statusCode}");
      print("${response.body}");
    }
  }

  String dropdownValue = "";
  String stateValued = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DropDownList '),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              "Drop Down",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              "Select Your State",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(0.0),
            child: DropdownButton<String>(
              value: chosenValue,
              elevation: 5,
              style: TextStyle(color: Colors.black,fontSize: 15),

              items: cityList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "Please choose a State",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (String? value) {
                setState(() {
                  chosenValue = value;
                });
              },
            ),
          ),

          SizedBox(
            height: 30,
          ),

          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              "Select Your Code",
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(0.0),
            child: DropdownButton<String>(
              value: StateValue,
              elevation: 5,
                style: TextStyle(color: Colors.black,fontSize: 20),

              items: statelist.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: Text(
                "Please choose a Code",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (String? value) {
                setState(() {
                  StateValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
//=======================================================================================


class StateModel {
  var stateCode;
  var stateName;

  StateModel({this.stateCode, this.stateName});

  StateModel.fromJson(Map<String, dynamic> json) {
    stateCode = json['StateCode'];
    stateName = json['StateName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    return data;
  }
}
