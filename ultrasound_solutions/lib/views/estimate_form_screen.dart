import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ultrasound_solutions/models/colors.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class EstimateFormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EstimateFormScreenState();
  }
}

class EstimateFormScreenState extends State<EstimateFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final listCount = 1;

  final TextEditingController _companyNameTC = new TextEditingController();
  final TextEditingController _addressTC = new TextEditingController();
  final TextEditingController _contactNameTC = new TextEditingController();
  final TextEditingController _contactNumberTC = new TextEditingController();
  final TextEditingController _serviceNotesTC = new TextEditingController();
  final TextEditingController _machineModelTC = new TextEditingController();
  final TextEditingController _machineMakeTC = new TextEditingController();
  final TextEditingController _machineSerialNumber = new TextEditingController();

  final emailTitle = "New Estimate Request";
  final submitEmail = "info@uscultrasound.com";
  final submitTitle = 'Submit Estimate';
  final submitContent =
      "This will submit your estimate to USC for review. Once submitted a representative will contact you shortly. Are you sure?";
  final submitTrue = "Submit";
  final submitFalse = "Cancel";

  //final serviceEmail = "service@uscultrasound.com";
  //final submitEmail = "info@uscultrasound.com";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Request Estimate"),
      ),
      body: new Center(
        child: _buildServiceForm(),
      ),
    );
  }

  Widget _buildServiceForm() {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: new Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextFormTitleField("Company Name: "),
                _buildTextFormField(_companyNameTC),
                _buildTextFormTitleField("Address: "),
                _buildTextFormField(_addressTC),
                _buildTextFormTitleField("Machine Make"),
                _buildTextFormField(_machineMakeTC),
                _buildTextFormTitleField("Machine Model"),
                _buildTextFormField(_machineModelTC),
                _buildTextFormTitleField("Machine Serial Number"),
                _buildTextFormField(_machineSerialNumber),
                _buildTextFormTitleField("Contact Name: "),
                _buildTextFormField(_contactNameTC),
                _buildTextFormTitleField("Contact Phone Number: "),
                _buildTextFormField(_contactNumberTC),
                _buildTextFormTitleField("Describe Estimate Requirements:  "),
                _buildTextFormField(_serviceNotesTC),
                _buildPhotoButton(),
                _buildSubmitButton(),
              ],
            ),
          )),
    );
  }

  Widget _buildTextFormField(TextEditingController textController) {
    return new Container(
      color: kUltraSoundFormTextFieldGrey,
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textController,
        style: TextStyle(color: kUltraSoundPrimaryText),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
        },
      ),
    );
  }

  Widget _buildPhotoButton() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Center(
        child: RaisedButton(
          onPressed: () {},
          child: Text(
            "Add Photos",
            style: TextStyle(color: kUltraSoundSurfaceWhite),
          ),
        ),
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
              _neverSatisfied();
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

  Widget _buildTextFormTitleField(String title) {
    return new Container(
      padding: EdgeInsets.all(8.0),
      child: Text(title,
          style: TextStyle(fontSize: 16.0, color: kUltraSoundPrimaryText)),
    );
  }

  void _postEstimateRequest(String toMailId, String subject, String body) {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    launch(url);
  }

  void _addImage() {
    //open camera or gallery
    //upload selected images to firebase storage
    //use link to images in email
  }

  Future<Null> _neverSatisfied() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(
            submitTitle,
            style: new TextStyle(color: kUltraSoundPrimaryText, fontSize: 18.0),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(
                  submitContent,
                  style: new TextStyle(
                    color: kUltraSoundPrimaryText,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text(
                  submitFalse,
                  style: new TextStyle(
                    color: kUltraSoundPrimaryText,
                    fontSize: 14.0,
                  ),
                )),
            new FlatButton(
                onPressed: () {
                  _postEstimateRequest(
                      submitEmail,
                      emailTitle,
                      "Company Name: " +
                          _companyNameTC.text +
                          "\n\n" +
                          "Address: " +
                          _addressTC.text +
                          "\n\n" +
                          "Machine Make: " +
                          _machineMakeTC.text +
                          "\n\n" +
                          "Machine Model: " +
                          _machineModelTC.text +
                          "\n\n" +
                          "Machine Serial Number: " +
                          _machineSerialNumber.text +
                          "\n\n" +
                          "Contact Name: " +
                          " " +
                          _contactNameTC.text +
                          "\n\n" +
                          "Contact Number: " +
                          _contactNumberTC.text +
                          "\n\n" +
                          "Estimate Notes: " +
                          _serviceNotesTC.text +
                          "\n\n\n\n" +
                          "*this estimate was submitted using the mobile app");
                  Navigator.of(context).pop();
                },
                child: new Text(
                  submitTrue,
                  style: new TextStyle(color: kUltraSoundOrange600),
                ))
          ],
        );
      },
    );
  }
}
