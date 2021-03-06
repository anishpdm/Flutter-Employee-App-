


import 'package:flutter/material.dart';
import 'package:flutter_app_api/models/employee.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';





class ViewEmployees extends StatefulWidget {
  @override
  _ViewEmployeesState createState() => _ViewEmployeesState();
}

class _ViewEmployeesState extends State<ViewEmployees> {



  Future<Employee> getData(String apiLink) async{

    return http.get(apiLink).then( (http.Response response){

      print(response.body.toString());

      employees=json.decode(response.body);

      return json.decode(response.body);

    }  );

  }





  List employees=[];

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          child: ListView.builder(
            itemCount: employees.length==null?0:employees.length,
            itemBuilder: (context,index){

              return Card(
                elevation: 10.0,
                child: ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text(employees[index]['empname'].toString()),
                  subtitle: Text("Mobile :"+ employees[index]["phoneno"].toString()   +  "\n"+ "Designation :" +employees[index]['designation'].toString() ),

                ),

              );

            },
          ),

        ),


      ),
    );
  }

  @override
  void initState() {
    getData("https://nodejsemployee.herokuapp.com/viewall");
  }
}
