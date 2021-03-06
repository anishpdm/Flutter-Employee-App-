


import 'package:flutter/material.dart';
import 'package:flutter_app_api/models/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

   showToast() {

    return Fluttertoast.showToast(
        msg: 'This is toast notification',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,

        backgroundColor: Colors.red,
        textColor: Colors.yellow
    );
  }

  TextEditingController empCode=TextEditingController();
  TextEditingController empName=TextEditingController();
  TextEditingController empPhone=TextEditingController();

  List employees=[];
  var name="";
  var phone="";



  Future<dynamic> sendData(String apiLink,x) async{

    return http.post(apiLink,body:x).then( (http.Response response){

      print(response.body.toString());
      var datafetched=json.decode(response.body);

      if(datafetched.length==0)
        {
          print("No Student Found");

         // var snackBar = SnackBar(content: Text('No Employee has found'));
          showToast();


          setState(() {

            empName.text="";
            empPhone.text="";

          });
        }

      else{
        setState(() {
          name=datafetched[0]['empname'];
          phone=datafetched[0]['phoneno'].toString();
          empName.text=name;

          empPhone.text=phone;
        });

      }



      return json.decode(response.body);

    }  );

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        ),

        body: Container(
          child: Column(
            children: [
              TextField(
                controller: empCode,

              ),
              RaisedButton(
                onPressed: (){

                  var getCode=empCode.text.toString();

                  var empdata={"empcode":getCode};

                  var datatosend= sendData("https://nodejsemployee.herokuapp.com/search",empdata);


                  Fluttertoast.showToast(
                      msg: "No Student Found",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );

                },
                child: Text("SEARCH"),

              ),


              TextField(
                decoration: InputDecoration(

labelText: "NAME"

                ),

                controller: empName,


                  onChanged: (value) {
                    print("The value entered is : $name");
                  }
              ),

              TextField(
                  decoration: InputDecoration(

                      labelText: "Phone Number"

                  ),

                  controller: empPhone,


                  onChanged: (value) {
                    print("The value entered is : $empPhone");
                  }
              )

            ],
          ),
        ),
      ),
    );
  }
}

