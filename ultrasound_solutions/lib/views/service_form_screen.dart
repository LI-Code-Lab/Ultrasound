import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultrasound_solutions/models/colors.dart';

class ServiceFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ServiceFormScreenState();
  }
}

class ServiceFormScreenState extends State<ServiceFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final listCount = 1;

  final TextEditingController _companyNameTC = new TextEditingController();
  final TextEditingController _contactNameTC = new TextEditingController();
  final TextEditingController _contactNumberTC = new TextEditingController();
  final TextEditingController _serviceNotesTC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Service Request"),
      ),
      body: new Center(
        child: _buildServiceForm(),
      ),
    );
  }

  Widget _buildServiceForm() {
    return Form(
        key: _formKey,
        child: new Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTextFormTitleField("Company Name: "),
              _buildTextFormField(_companyNameTC),
              _buildTextFormTitleField("Contact Name: "),
              _buildTextFormField(_contactNameTC),
              _buildTextFormTitleField("Contact Phone Number: "),
              _buildTextFormField(_contactNumberTC),
              _buildTextFormTitleField("Service Notes: "),
              _buildTextFormField(_serviceNotesTC),
              _buildSubmitButton(),
            ],
          ),
        ));
  }

  Widget _buildTextFormField(TextEditingController textController) {
    return new Container(
      color: kUltraSoundFormTextFieldGrey,
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textController,
        style: TextStyle(
          color: kUltraSoundPrimaryText
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Center(
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              //if the form is valid do something
            }
          },
          child: Text(
              "Submit",
              style: TextStyle(
                color: kUltraSoundSurfaceWhite,
              ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormTitleField(String title){
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: kUltraSoundPrimaryText
          )),
    );
  }

  void _postServiceRequest(){
    //do something with the text controller text 
  }
}
