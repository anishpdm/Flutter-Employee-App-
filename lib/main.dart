import 'package:flutter/material.dart';
import 'package:flutter_app_api/models/employee.dart';
import 'package:flutter_app_api/screens/delete.dart';
import 'package:flutter_app_api/screens/search.dart';
import 'package:flutter_app_api/screens/searchemployee.dart';
import 'package:flutter_app_api/screens/viewemployees.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

void main() {
  runApp(EmployeeDelete());
}

Future<dynamic> sendData(String apiLink,{Map body}) async{

  return http.post(apiLink,body:body).then( (http.Response response){

    print(response.body.toString());

    return json.decode(response.body);

  }  );

}



class MyApp extends StatelessWidget {

  TextEditingController name=TextEditingController();
  TextEditingController empcode=TextEditingController();
  TextEditingController Address=TextEditingController();
  TextEditingController Phone=TextEditingController();

  TextEditingController Designation=TextEditingController();
  TextEditingController Email=TextEditingController();
  TextEditingController Salary=TextEditingController();
  TextEditingController Company=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: <Widget>[

              TextField(
                controller:empcode,
                decoration: InputDecoration(
                    hintText: "Enter Employee Code"

                ),),
              
              TextField(
                controller: name,

                decoration: InputDecoration(
                hintText: "Enter Employee Name"
                
              ),),

              TextField(
                controller: Address,
                decoration: InputDecoration(
                  hintText: "Enter Address"

              ),),

              TextField(
                controller: Phone,
                decoration: InputDecoration(
                  hintText: "Enter Phone Number"

              ),),

              TextField(
                controller:Designation,
                  decoration: InputDecoration(
                  hintText: "Enter Designation"

              ),),


              TextField(
                controller:Email,
                decoration: InputDecoration(
                    hintText: "Enter Email"

                ),),


              TextField(
                controller:Salary,
                decoration: InputDecoration(
                    hintText: "Enter Salary"

                ),),


              TextField(
                controller:Company,
                decoration: InputDecoration(
                    hintText: "Enter Company Name"

                ),),
              
              RaisedButton(onPressed: () async {

                var getName=name.text;
                var getCompany=Company.text;
                var getSalary=(Salary.text);
                var getEmail=Email.text;
                var getDesignation=Designation.text;
                var getPhone=(Phone.text);
                var getAddress=Address.text;
                var getempcode=(empcode.text);

              Employee empdata=new Employee(
                  id:"",
                  empname:getName,
                  address:getAddress,
                  phoneno:getPhone,
                  designation:getDesignation,
                  email:getEmail,
                  salary:getSalary,
                  companyname:getCompany,
                  empcode:getempcode

              );


        Employee datatosend=await sendData("https://nodejsemployee.herokuapp.com/empadd",body:empdata.toJson());



              },
              child: Text("SUBMIT"),),


           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewEmployees()));

             },
             child: Container(
               child: Text("View All"),

             ),
           )

              
            ],
          ),
        ),
      ),
    );
  }
}
