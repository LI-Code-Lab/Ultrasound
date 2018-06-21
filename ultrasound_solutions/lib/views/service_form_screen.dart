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
              _buildTextFormField(),
              _buildTextFormTitleField("Contact Name: "),
              _buildTextFormField(),
              _buildTextFormTitleField("Contact Phone Number: "),
              _buildTextFormField(),
              _buildTextFormTitleField("Service Notes: "),
              _buildTextFormField(),
              _buildSubmitButton(),
            ],
          ),
        ));
  }

  Widget _buildTextFormField() {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
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
      padding: EdgeInsets.all(8.0),
      child: new Center(
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              //if the form is valid do something
            }
          },
          child: Text("Submit"),
        ),
      ),
    );
  }

  Widget _buildTextFormTitleField(String title){
    return Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          color: kUltraSoundPrimaryText
        ));
  }
}
