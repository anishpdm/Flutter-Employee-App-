
class Employee {

  //String _id;
  String empname;
  String address;
	String phoneno;
  String designation;
  String email;
	String salary;
  String companyname;
	String empcode;


	Employee({ this.empname, this.address, this.phoneno, this.designation,
      this.email, this.salary, this.companyname, this.empcode });


  Employee.fromJsonMap(Map<String, dynamic> map):
		//_id = map["_id"],
		empname = map["empname"],
		address = map["address"],
		phoneno = map["phoneno"],
		designation = map["designation"],
		email = map["email"],
		salary = map["salary"],
		companyname = map["companyname"],
		empcode = map["empcode"];

	Map<String, String> toJson() {
		final Map<String, String> data = new Map<String, String>();
		//data['_id'] = _id;
		data['empname'] = empname;
		data['address'] = address;
		data['phoneno'] = phoneno;
		data['designation'] = designation;
		data['email'] = email;
		data['salary'] = salary;
		data['companyname'] = companyname;
		data['empcode'] = empcode;
		return data;
	}
}
