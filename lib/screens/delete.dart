

import 'package:flutter/material.dart';
import 'package:flutter_app_api/models/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class EmployeeDelete extends StatefulWidget {
  @override
  _EmployeeSearchState createState() => _EmployeeSearchState();
}

class _EmployeeSearchState extends State<EmployeeDelete> {

  Future<dynamic> updateData(String apiLink,{Map body}) async{

    return http.post(apiLink,body:body).then( (http.Response response){

      print(response.body.toString());

      return json.decode(response.body);

    }  );

  }





  Future<dynamic> deleteData(String apiLink, empid ) async{

    return http.post(apiLink,body:empid).then( (http.Response response){

      print(response.body.toString());

      var result=json.decode(response.body);

      setState(() {
        empphone.text="";
        empname.text="";
      });

      return result;

    }  );

  }




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

        getempName=result[0]['empname'];
        getempPhone=result[0]['phoneno'].toString();
        getempCompanyName=result[0]['companyname'].toString();
        getempSalary=result[0]['salary'].toString();
        getempDesignation=result[0]['designation'].toString();
        getempAddress=result[0]['address'].toString();
        getempCode=result[0]['empcode'].toString();


        getId=result[0]["_id"].toString();


        setState(() {
          empname.text=getempName;
          empphone.text=getempPhone;

          empAddress.text=getempAddress;
          empDesignation.text=getempDesignation;
          empcode2.text=getempCode;
          empSalary.text=getempSalary;
          empCompany.text=getempCompanyName;
          empEmail.text=getempEmail;

        });



      }

      return json.decode(response.body);

    }  );

  }

  TextEditingController empcode=TextEditingController();
  TextEditingController empname=TextEditingController();
  TextEditingController empphone=TextEditingController();
  TextEditingController empcode2=TextEditingController();
  TextEditingController empAddress=TextEditingController();
  TextEditingController empDesignation=TextEditingController();
  TextEditingController empEmail=TextEditingController();
  TextEditingController empSalary=TextEditingController();
  TextEditingController empCompany=TextEditingController();

  var getId="";
  var getempPhone="";
  var getempName="";
  var getempAddress="";
  var getempDesignation="";
  var getempEmail="";
  var getempSalary="";
  var getempCompanyName="";
  var getempCode="";
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

              TextField(
                controller: empcode2,


                decoration: InputDecoration(
                    labelText: "Employee Code",

                    hintText: "Employee Code"

                ),
              ),
              TextField(
                controller: empAddress,


                decoration: InputDecoration(
                    labelText: "Employee Address",

                    hintText: "Employee Address"

                ),
              ),

              TextField(
                controller: empDesignation,


                decoration: InputDecoration(
                    labelText: "Employee Designation",

                    hintText: "Employee Designation"

                ),
              ),

              TextField(
                controller: empEmail,


                decoration: InputDecoration(
                    labelText: "Employee Email",

                    hintText: "Employee Email"

                ),
              ),

              TextField(
                controller: empSalary,


                decoration: InputDecoration(
                    labelText: "Employee Salary",

                    hintText: "Employee Salary"

                ),
              ),


              TextField(
                controller: empCompany,


                decoration: InputDecoration(
                    labelText: "Employee Company name",

                    hintText: "Employee  Company name"

                ),
              ),



              FlatButton(
                color: Colors.red,
                  onPressed: (){

                  print(getId);



                  var result=deleteData("https://nodejsemployee.herokuapp.com/delete",{"id":getId});


                  },
                  child: Text("DELETE")),


              FlatButton(
                  color: Colors.yellow,
                  onPressed: () async{



                var newEmpname=empname.text;
                var newEmpCode=empcode2.text;
                var newEmpAddress=empAddress.text;
                var newEmpDesignation=empDesignation.text;
                var newEmpSalary=empSalary.text;
                var newEmpCompanyname=empCompany.text;
                var newEmpPhone=empphone.text;
                var newEmpEmail=empEmail.text;



                Employee empdata=new Employee(
                  id: getId,
                    empname:newEmpname,
                    address:newEmpAddress,
                    phoneno:newEmpPhone,
                    designation:newEmpDesignation,
                    email:newEmpEmail,
                    salary:newEmpSalary,
                    companyname:newEmpCompanyname,
                    empcode:newEmpCode

                );

                Employee datatosend=await updateData("https://nodejsemployee.herokuapp.com/update",body:empdata.toJson());

              },


                  child: Text("UPDATE"))


            ],
          ),
        ),
      ),
    );
  }
}
