

import 'package:flutter/material.dart';
import 'package:flutter_app_api/models/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EmployeeSearch extends StatefulWidget {
  @override
  _EmployeeSearchState createState() => _EmployeeSearchState();
}

class _EmployeeSearchState extends State<EmployeeSearch> {



  Future<dynamic> searchData(String apiLink, empcode ) async{

    return http.post(apiLink,body:empcode).then( (http.Response response){

      print(response.body.toString());

      var result=json.decode(response.body);

      if(result.length==0)
        {
          print("Invalid Employee Code");

          empphone.text="";
          empname.text="";

        }
      else{

        var getName=result[0]['empname'];
        var getPhone=result[0]['phoneno'].toString();


        setState(() {
          empname.text=getName;
          empphone.text=getPhone;

        });



      }

      return json.decode(response.body);

    }  );

  }

  TextEditingController empcode=TextEditingController();
  TextEditingController empname=TextEditingController();
  TextEditingController empphone=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              TextField(
                controller: empcode,
                decoration: InputDecoration(
                  labelText: "Employee Code",
                  hintText: "Enter Employee Code"
                )
                ,
              ),

              RaisedButton(onPressed: (){

                var getEmpCode=empcode.text.toString();
                
                var result=searchData("https://nodejsemployee.herokuapp.com/search",{"empcode":getEmpCode});

                print(result);





              },

                child: Text("SEARCH"),

              ),

              TextField(

controller: empname,

                decoration: InputDecoration(
                  labelText: "Employee Name",
                  hintText: "Employee Name"
                ),
              ),
              TextField(
                controller: empphone,


                decoration: InputDecoration(
                    labelText: "Employee Phone",

                    hintText: "Employee Phone"

                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
